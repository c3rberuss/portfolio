package com.c3rberuss.mnctest.presentation.home

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
import com.c3rberuss.mnctest.databinding.PhotoItemBinding
import com.c3rberuss.mnctest.utils.BlurHashDecoder
import com.c3rberuss.mnctest.utils.DiffUtilCallbackPhotos
import com.c3rberuss.mnctest.utils.OnPhotoAddToFavoritesListener
import java.util.*


class PhotoListAdapter(
    private val context: Context,
    private val addToFavoritesListener: OnPhotoAddToFavoritesListener
) :
    RecyclerView.Adapter<PhotoListAdapter.PhotoViewHolder>(), Filterable {

    private var photos = mutableListOf<Photo>()
    private var photosFiltered = mutableListOf<Photo>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PhotoViewHolder {
        val view: PhotoItemBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.photo_item,
            parent,
            false
        )
        return PhotoViewHolder(view)
    }

    override fun onBindViewHolder(holder: PhotoViewHolder, position: Int) {
        holder.bind(photosFiltered[position], addToFavoritesListener)
    }

    fun submitList(newVerbs: List<Photo>) {
        val result = DiffUtil.calculateDiff(DiffUtilCallbackPhotos(photos, newVerbs))
        photos = newVerbs.toMutableList()
        photosFiltered = newVerbs.toMutableList()
        result.dispatchUpdatesTo(this)
    }

    override fun getItemCount(): Int {
        return photosFiltered.size
    }

    override fun getFilter(): Filter {
        return PhotoFilter()
    }

    inner class PhotoViewHolder(private val binding: PhotoItemBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(photo: Photo, onPhotoAddToFavoritesListener: OnPhotoAddToFavoritesListener) {
            binding.photo = photo

            val bitmap = BlurHashDecoder.decode(photo.blurHash, 20, 12)
            val hash = BitmapDrawable(context.resources, bitmap)

            Glide.with(binding.root)
                .load(photo.urls.full)
                .placeholder(hash)
                .into(binding.imageView)

                binding.root.setOnClickListener {
                    onPhotoAddToFavoritesListener.onAdd(photo)
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