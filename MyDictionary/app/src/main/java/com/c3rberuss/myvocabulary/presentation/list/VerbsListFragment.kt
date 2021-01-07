package com.c3rberuss.myvocabulary.presentation.list

import android.app.SearchManager
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.R
import com.c3rberuss.myvocabulary.databinding.FragmentVerbsListBinding
import com.c3rberuss.myvocabulary.utils.getNavigationResult

class VerbsListFragment : Fragment(), OnVerbSelectedListener {

    private val viewModel by activityViewModels<VerbsViewModel>()
    private lateinit var adapter: VerbsListAdapter
    private lateinit var binding: FragmentVerbsListBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setHasOptionsMenu(true)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentVerbsListBinding.inflate(inflater, container, false)
        binding.lifecycleOwner = this
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.verbsList.layoutManager = LinearLayoutManager(requireContext())
        adapter = VerbsListAdapter(requireContext(), this)
        binding.verbsList.adapter = adapter
        binding.verbsList.addItemDecoration(
            DividerItemDecoration(
                requireContext(),
                LinearLayoutManager.VERTICAL
            )
        )

        binding.refresher.setOnRefreshListener {
            viewModel.obtainVerbs()
        }

        viewModel.state.observe(viewLifecycleOwner, Observer {

            if (it != null) {

                when (it) {

                    is Resource.Success<Boolean> -> {
                        viewModel.obtainVerbs()
                    }

                }

            }

        })

        viewModel.verbs.observe(viewLifecycleOwner, Observer { result ->

            if (binding.refresher.isRefreshing) {
                binding.refresher.isRefreshing = false
            }

            when (result) {
                is Resource.Loading -> {
                    binding.circularProgress.visibility = View.VISIBLE
                    binding.noContent.visibility = View.GONE
                    binding.verbsList.visibility = View.GONE
                }
                is Resource.Success<List<Verb>> -> {

                    binding.circularProgress.visibility = View.GONE

                    adapter.submitList(result.data)
                    if (result.data.isEmpty()) {
                        binding.noContent.text = getString(R.string.vocabulary_empty)
                        binding.verbsList.visibility = View.GONE
                        binding.noContent.visibility = View.VISIBLE
                    } else {
                        binding.verbsList.visibility = View.VISIBLE
                        binding.noContent.visibility = View.GONE
                    }
                }
                is Resource.Failure<List<Verb>> -> {
                    binding.circularProgress.visibility = View.GONE
                    binding.verbsList.visibility = View.GONE
                    binding.noContent.text = getString(R.string.load_failed)
                    binding.noContent.visibility = View.VISIBLE
                }
            }

        })

        binding.btnAddVerb.setOnClickListener {
            findNavController().navigate(R.id.action_verbsListFragment_to_createVerbFragment)
        }

        getNavigationResult()?.observe(viewLifecycleOwner, Observer {
            viewModel.obtainVerbs()
            Log.d("RESULT", "onViewCreated: $it")
        })

    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.menu, menu)

        val searchManager =
            requireActivity().getSystemService(Context.SEARCH_SERVICE) as SearchManager


        (menu.findItem(R.id.verb_search).actionView as SearchView).apply {
            setSearchableInfo(searchManager.getSearchableInfo(requireActivity().componentName))

            setOnQueryTextListener(object : SearchView.OnQueryTextListener {
                override fun onQueryTextSubmit(query: String?): Boolean {
                    return true
                }

                override fun onQueryTextChange(newText: String?): Boolean {
                    adapter.VerbFilter().filter(newText)
                    return true
                }
            })
        }
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        if (item.itemId == R.id.delete_action) {
            viewModel.deleteAllSelected()
        }

        return true
    }

    override fun onSelected(verb: Verb) {
        Log.d("VerbListFragment", "onSelected: $verb")
        viewModel.addVerbSelected(verb)
    }

    override fun onUnselected(verb: Verb) {
        Log.d("VerbListFragment", "onUnselected: $verb")
        viewModel.removeVerbSelected(verb)
    }
}