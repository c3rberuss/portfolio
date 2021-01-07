package com.c3rberuss.mnctest.presentation.favorites

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.StaggeredGridLayoutManager
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.mnctest.R
import com.c3rberuss.mnctest.databinding.FragmentFavoritesBinding
import com.c3rberuss.mnctest.utils.OnPhotoRemoveFromFavoritesListener

class FavoritesFragment : Fragment(), OnPhotoRemoveFromFavoritesListener {

    private val viewModel by activityViewModels<FavoritesViewModel>()
    private lateinit var binding: FragmentFavoritesBinding
    private lateinit var adapter: FavoritesListAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = FragmentFavoritesBinding.inflate(inflater, container, false)
        binding.lifecycleOwner = this

        println("FAVORITES CREATED")

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.favoriteList.layoutManager =
            StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL)
        adapter = FavoritesListAdapter(requireContext(), this)
        binding.favoriteList.adapter = adapter

        viewModel.getAllFavorites()

        viewModel.photos.observe(viewLifecycleOwner, { result ->
            when (result) {
                is Resource.Loading -> {
                    binding.loadingIndicator.visibility = View.VISIBLE
                    binding.noContent.visibility = View.GONE
                    binding.favoriteList.visibility = View.GONE
                }
                is Resource.Success<List<Photo>> -> {

                    binding.loadingIndicator.visibility = View.GONE

                    adapter.submitList(result.data)

                    if (result.data.isEmpty()) {
                        binding.noContent.text = getString(R.string.app_name)
                        binding.favoriteList.visibility = View.GONE
                        binding.noContent.visibility = View.VISIBLE
                    } else {
                        binding.favoriteList.visibility = View.VISIBLE
                        binding.noContent.visibility = View.GONE
                    }
                }
                is Resource.Failed<List<Photo>> -> {
                    binding.loadingIndicator.visibility = View.GONE
                    binding.favoriteList.visibility = View.GONE
                    binding.noContent.text = getString(R.string.title_favorites)
                    binding.noContent.visibility = View.VISIBLE
                }
            }
        })
    }

    override fun onRemove(photo: Photo) {
        viewModel.removeFromFavorite(photo)
    }
}