package com.c3rberuss.myvocabulary.presentation.create

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import android.widget.Toast
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.R
import com.c3rberuss.myvocabulary.databinding.FragmentCreateVerbBinding
import com.c3rberuss.myvocabulary.utils.hideKeyboard
import com.c3rberuss.myvocabulary.utils.setNavigationResult
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CreateVerbFragment : Fragment() {

    private val viewModel by activityViewModels<CreateVerbViewModel>()
    private lateinit var binding: FragmentCreateVerbBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setHasOptionsMenu(false)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentCreateVerbBinding.inflate(inflater, container, false)
        binding.vm = viewModel
        binding.lifecycleOwner = this
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel.baseForm.observe(viewLifecycleOwner, Observer {
            viewModel.validateData()
        })

        viewModel.presentProgressive.observe(viewLifecycleOwner, Observer {
            viewModel.validateData()
        })

        viewModel.past.observe(viewLifecycleOwner, Observer {
            viewModel.validateData()
        })

        viewModel.state.observe(viewLifecycleOwner, Observer {
            when (it) {
                is Resource.Loading -> {
                    binding.btnSaveVerb.visibility = View.GONE
                    binding.circularProgress.visibility = View.VISIBLE
                }
                is Resource.Success<Verb> -> {
                    binding.circularProgress.visibility = View.GONE
                    binding.btnSaveVerb.visibility = View.VISIBLE

                    viewModel.clearFields()
                    hideKeyboard()
                    setNavigationResult("saved")
                    findNavController().popBackStack()
                    Toast.makeText(requireContext(), "Saved", Toast.LENGTH_SHORT).show()
                }
                is Resource.Failure<Verb> -> {
                    binding.circularProgress.visibility = View.GONE
                    binding.btnSaveVerb.visibility = View.VISIBLE
                    Toast.makeText(requireContext(), it.exception.message, Toast.LENGTH_SHORT).show()
                }
            }
        })

        binding.btnSaveVerb.setOnClickListener {
            viewModel.save()
        }
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        menu.removeItem(R.id.verb_search)
        super.onCreateOptionsMenu(menu, inflater)
    }
}