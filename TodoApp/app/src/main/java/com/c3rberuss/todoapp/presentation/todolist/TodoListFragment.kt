package com.c3rberuss.todoapp.presentation.todolist

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.activityViewModels
import androidx.navigation.Navigation.findNavController
import androidx.navigation.findNavController
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.TodoList
import com.c3rberuss.todoapp.databinding.FragmentTodoListBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class TodoListFragment : Fragment(), TodoListListener {

    private val viewModel by activityViewModels<TodoListViewModel>()
    private lateinit var binding: FragmentTodoListBinding
    private lateinit var adapter: TodoListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = FragmentTodoListBinding.inflate(inflater, container, false)
        binding.lifecycleOwner = this

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.todoList.layoutManager =
            LinearLayoutManager(requireContext(), LinearLayoutManager.VERTICAL, false)

        adapter = TodoListAdapter(requireContext(), this)
        binding.todoList.adapter = adapter

        viewModel.todoListLiveData.observe(viewLifecycleOwner, {

            when (it) {
                is Resource.Loading -> {

                }
                is Resource.Success<List<TodoList>> -> {
                    adapter.settodoLists((it as Resource.Success<List<TodoList>>).data)
                }
                else -> {

                }
            }

        })
    }

    override fun onTap(todoList: TodoList) {
        val action = TodoListFragmentDirections.actionTodoListFragmentToTodoDetailFragment(
                todoList.id,
                todoList.title,
                todoList.state
            )

        this.findNavController().navigate(action)
    }

    override fun onRemove(todoList: TodoList) {
        TODO("Not yet implemented")
    }
}