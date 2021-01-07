package com.c3rberuss.myvocabulary.presentation.list

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.R
import com.c3rberuss.myvocabulary.databinding.VerbItemBinding
import java.util.*


class VerbsListAdapter(
    private val context: Context,
    private val verbSelectedListener: OnVerbSelectedListener
) :
    RecyclerView.Adapter<VerbsListAdapter.VerbViewHolder>(), Filterable {

    private var verbs = mutableListOf<Verb>()
    private var verbsFiltered = mutableListOf<Verb>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VerbViewHolder {
        val view: VerbItemBinding = DataBindingUtil.inflate(
            LayoutInflater.from(context),
            R.layout.verb_item,
            parent,
            false
        )
        return VerbViewHolder(view)
    }

    override fun onBindViewHolder(holder: VerbViewHolder, position: Int) {
        holder.bind(verbsFiltered[position])
    }

    fun submitList(newVerbs: List<Verb>) {
        val result = DiffUtil.calculateDiff(Callback(verbs, newVerbs))
        verbs = newVerbs.toMutableList()
        verbsFiltered = newVerbs.toMutableList()
        result.dispatchUpdatesTo(this)
    }

    override fun getItemCount(): Int {
        return verbsFiltered.size
    }

    override fun getFilter(): Filter {
        return VerbFilter()
    }

    inner class VerbViewHolder(private val binding: VerbItemBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(verb: Verb) {
            binding.verb = verb
            binding.selected.setOnCheckedChangeListener { _, isSelected ->

                verbs[adapterPosition].selected = isSelected

                if (isSelected) {
                    verbSelectedListener.onSelected(verb)
                } else {
                    verbSelectedListener.onUnselected(verb)
                }
            }
        }

    }

    inner class VerbFilter : Filter() {
        override fun performFiltering(constraint: CharSequence?): FilterResults {
            val results = FilterResults()
            val query = constraint.toString().toLowerCase(Locale.ROOT)

            val filtered = mutableListOf<Verb>()

            if (constraint == null || constraint.toString().isEmpty()) {
                results.count = verbs.size
                results.values = verbs
            } else {
                verbs.forEach {
                    if (it.baseForm.toLowerCase(Locale.getDefault()).contains(query) ||
                        it.meaning.toLowerCase(Locale.getDefault()).contains(query)
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
            verbsFiltered = results?.values as MutableList<Verb>
            notifyDataSetChanged()
        }

    }
}


interface OnVerbSelectedListener {
    fun onSelected(verb: Verb)
    fun onUnselected(verb: Verb)
}

private class Callback(val oldItems: List<Verb>, val newItems: List<Verb>) : DiffUtil.Callback() {
    override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
        return oldItems[oldItemPosition].id == newItems[newItemPosition].id
    }

    override fun getOldListSize(): Int {
        return oldItems.size
    }

    override fun getNewListSize(): Int {
        return newItems.size
    }

    override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
        return oldItems[oldItemPosition] == newItems[newItemPosition]
    }

}