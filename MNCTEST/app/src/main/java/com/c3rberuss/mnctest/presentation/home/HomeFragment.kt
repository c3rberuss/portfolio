package com.c3rberuss.mnctest.presentation.home

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
import com.c3rberuss.mnctest.databinding.FragmentHomeBinding
import com.c3rberuss.mnctest.utils.OnPhotoAddToFavoritesListener
import com.c3rberuss.mnctest.utils.OnPhotoRemoveFromFavoritesListener

class HomeFragment : Fragment(), OnPhotoAddToFavoritesListener, OnPhotoRemoveFromFavoritesListener {

    private val viewModel by activityViewModels<HomeViewModel>()
    private lateinit var binding: FragmentHomeBinding
    private lateinit var adapter: PhotoListAdapter

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false)
        binding.lifecycleOwner = this
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.photosList.layoutManager =
            StaggeredGridLayoutManager(2, StaggeredGridLayoutManager.VERTICAL)
        adapter = PhotoListAdapter(requireContext(), this)
        binding.photosList.adapter = adapter

        binding.refresher.setOnRefreshListener {
            viewModel.fetchAllPhotos()
        }

        viewModel.photos.observe(viewLifecycleOwner, { result ->

            if (binding.refresher.isRefreshing) {
                binding.refresher.isRefreshing = false
            }

            when (result) {
                is Resource.Loading -> {
                    binding.circularProgress.visibility = View.VISIBLE
                    binding.noContent.visibility = View.GONE
                    binding.photosList.visibility = View.GONE
                }
                is Resource.Success<List<Photo>> -> {

                    binding.circularProgress.visibility = View.GONE

                    adapter.submitList(result.data)
                    if (result.data.isEmpty()) {
                        binding.noContent.text = getString(R.string.app_name)
                        binding.photosList.visibility = View.GONE
                        binding.noContent.visibility = View.VISIBLE
                    } else {
                        binding.photosList.visibility = View.VISIBLE
                        binding.noContent.visibility = View.GONE
                    }
                }
                is Resource.Failed<List<Photo>> -> {
                    binding.circularProgress.visibility = View.GONE
                    binding.photosList.visibility = View.GONE
                    binding.noContent.text = getString(R.string.title_favorites)
                    binding.noContent.visibility = View.VISIBLE
                }
            }

        })
    }

    override fun onAdd(photo: Photo) {
        viewModel.addToFavorite(photo)
    }

    override fun onRemove(photo: Photo) {

    }
}