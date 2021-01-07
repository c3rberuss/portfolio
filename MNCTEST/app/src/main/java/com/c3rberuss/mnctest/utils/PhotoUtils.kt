package com.c3rberuss.mnctest.utils

import androidx.recyclerview.widget.DiffUtil
import com.c3rberuss.core.domain.Photo

interface OnPhotoAddToFavoritesListener {
    fun onAdd(photo: Photo)
}

interface OnPhotoRemoveFromFavoritesListener {
    fun onRemove(photo: Photo)
}


class DiffUtilCallbackPhotos(val oldItems: List<Photo>, val newItems: List<Photo>) : DiffUtil.Callback() {
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

