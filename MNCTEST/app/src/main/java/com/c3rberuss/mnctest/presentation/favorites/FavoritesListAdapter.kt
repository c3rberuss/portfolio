package com.c3rberuss.mnctest.presentation.favorites

import android.content.Context
import android.graphics.drawable.BitmapDrawable
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.mnctest.R
import com.c3rberuss.mnctest.databinding.FavoriteItemBinding
import com.c3rberuss.mnctest.utils.BlurHashDecoder
import com.c3rberuss.mnctest.utils.DiffUtilCallbackPhotos
import com.c3rberuss.mnctest.utils.OnPhotoRemoveFromFavoritesListener
import java.util.*


class FavoritesListAdapter(
    private val context: Context,
    private val removeFromFavoritesListener: OnPhotoRemoveFromFavoritesListener,
) :
    RecyclerView.Adapter<FavoritesListAdapter.PhotoViewHolder>(), Filterable {

    private var photos = mutableListOf<Photo>()
    private var photosFiltered = mutableListOf<Photo>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PhotoViewHolder {
        val view: FavoriteItemBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.favorite_item,
            parent,
            false
        )
        return PhotoViewHolder(view)
    }

    override fun onBindViewHolder(holder: PhotoViewHolder, position: Int) {
        holder.bind(photosFiltered[position])
    }

    fun submitList(newPhotos: List<Photo>) {
        val result = DiffUtil.calculateDiff(DiffUtilCallbackPhotos(photos, newPhotos))
        photos = newPhotos.toMutableList()
        photosFiltered = newPhotos.toMutableList()
        result.dispatchUpdatesTo(this)
    }

    override fun getItemCount(): Int {
        return photosFiltered.size
    }

    override fun getFilter(): Filter {
        return PhotoFilter()
    }

    inner class PhotoViewHolder(private val binding: FavoriteItemBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(photo: Photo) {
            binding.photo = photo

            val bitmap = BlurHashDecoder.decode(photo.blurHash, 20, 12)
            val hash = BitmapDrawable(context.resources, bitmap)

            Glide.with(binding.root)
                .load(photo.urls.full)
                .placeholder(hash)
                .into(binding.favoritePhoto)

            binding.root.setOnClickListener {
                photosFiltered.removeAt(adapterPosition)
                notifyItemRemoved(adapterPosition)
                removeFromFavoritesListener.onRemove(photo)
            }
        }

    }

    inner class PhotoFilter : Filter() {
        override fun performFiltering(constraint: CharSequence?): FilterResults {
            val results = FilterResults()
            val query = constraint.toString().toLowerCase(Locale.ROOT)

            val filtered = mutableListOf<Photo>()

            if (constraint == null || constraint.toString().isEmpty()) {
                results.count = photos.size
                results.values = photos
            } else {
                photos.forEach {
                    if (it.user.name.toLowerCase(Locale.getDefault()).contains(query) ||
                        it.user.username.toLowerCase(Locale.getDefault()).contains(query)
                    ) {
                        filtered.add(it)
                    }
                }

                results.count = filtered.size
                results.values = filtered
            }

            return results
        }

        override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
            photosFiltered = results?.values as MutableList<Photo>
            notifyDataSetChanged()
        }

    }
}