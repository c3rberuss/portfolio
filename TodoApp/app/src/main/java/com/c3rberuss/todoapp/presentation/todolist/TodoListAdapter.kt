package com.c3rberuss.todoapp.presentation.todolist

import android.content.Context
import android.graphics.Paint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.c3rberuss.core.domain.TodoList
import com.c3rberuss.todoapp.R
import com.c3rberuss.todoapp.databinding.TodoListItemBinding

class TodoListAdapter(
    private val context: Context,
    private val todoListListener: TodoListListener
) :
    RecyclerView.Adapter<TodoListAdapter.ViewHolder>() {

    private var todoLists = mutableListOf<TodoList>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view: TodoListItemBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.todo_list_item,
            parent,
            false
        )

        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(todoLists[position])
    }

    override fun getItemCount(): Int {
        return todoLists.size
    }

    fun settodoLists(newTodoLists: List<TodoList>) {
        val lastIndex = itemCount
        todoLists.addAll(newTodoLists)
        notifyItemRangeRemoved(lastIndex, itemCount - 1)
    }

    inner class ViewHolder(private val binding: TodoListItemBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(todoList: TodoList) {
            binding.todoListNumber.text = (adapterPosition + 1).toString()

            if(todoList.state){
                binding.todoListTitle.paintFlags = (binding.todoListTitle.paintFlags or Paint.STRIKE_THRU_TEXT_FLAG)
            }

            binding.todoList = todoList

            binding.root.setOnClickListener {
                todoListListener.onTap(todoList)
            }

            binding.root.setOnLongClickListener {
                true
            }
        }

    }

}

interface TodoListListener {
    fun onTap(todoList: TodoList)
    fun onRemove(todoList: TodoList)
}