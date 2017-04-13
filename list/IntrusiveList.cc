/*
 * IntrusiveList.cc
 *
 *  Created on: 2017Äê4ÔÂ13ÈÕ
 *      Author: Light
 */
#include<iostream>
#include<vector>
#include <iterator>
#include <string>
#include <sstream>

template<class T>
class LinkList {
public:
	struct ListNode;
	class iterator {
	public:
		iterator(ListNode* node) :
				node_(node) {
		}
		iterator& operator ++() {
			if (node_) {
				node_ = node_->next_;
			}
			return *this;
		}
		iterator& operator --() {
			if (node_) {
				node_ = node_->prev_;
			}
			return *this;
		}
		bool operator ==(const iterator& iter) {
			return node_ == iter.node_;
		}
		bool operator !=(const iterator& iter) {
			return !operator ==(iter);
		}
		T& operator *() {
			return *static_cast<T*>(node_);
		}

		T* operator ->() {
			return node_;
		}
	private:
		ListNode* node_;
	};

	struct ListNode {
		template<class ... Args>
		ListNode() :
				list_(nullptr), prev_(nullptr), next_(nullptr) {
		}
		LinkList* list_;
		ListNode* prev_;
		ListNode* next_;
	};

	LinkList() :
			head_(new ListNode()), len_(0) {
		head_->list_ = this;
		head_->prev_ = head_;
		head_->next_ = head_;
	}

	~LinkList() {
		ListNode* node_ = head_->next_;
		while (node_ != head_) {
			head_->next_ = node_->next_;
			delete node_;
			node_ = head_->next_;
		}
		delete head_;
	}

	template<class ... Args>
	T* getFirst() {
		return (T*) head_->next_;
	}
	T* getLast() {
		return head_->prev_;
	}
	bool isEmpty() {
		return len_ == 0;
	}
	int length() {
		return len_;
	}

	void add(T* t) {
		// append [t] into LinkList.
		insert(t, head_->prev_);
	}

	void addFirst(T* t) {
		// add [t] at the first.
		insert(t, head_);
	}

	void insertBefore(T* t, T* at) {
		// Insert [t] before [at].
		insert(t, at->prev_);
	}

	void insertAfter(T* t, T* at) {
		// Insert [t] after [at].
		insert(t, at);
	}

	void insert(T* t, ListNode* at) {
		if (t->list_ != nullptr) {
			throw std::runtime_error("ListNode is already in a LinkList.");
		}
		t->list_ = this; // Link value into LinkList.
		t->prev_ = at;
		t->next_ = at->next_;
		at->next_ = t;
		t->next_->prev_ = t;
		len_++;
	}

	T* remove(T* t) {
		t->prev_->next_ = t->next_;
		t->next_->prev_ = t->prev_;
		t->list_ = nullptr;
		t->prev_ = t->next_ = nullptr;
		len_--;
		return t;
	}

	void reverseBetween(int m, int n) {
		if (m < 1 || n > len_) {
			std::string str = "Index out of bounds. Wrong range ("
					+ std::to_string(m) + "," + std::to_string(n) + ")";
			throw std::range_error(str);
		}
		int cnt = n - m; // 1 <= m <= n <= LinkList.Length
		T* start = getFirst();
		for (int i = 1; i < m; i++) {
			//start points to the first node_ to be reversed.
			start = (T*) start->next_;
		}
		T* end = start;
		while (cnt > 0) {
			// Insert node_s from m to n into list_.
			T* curr = (T*) end->next_;
			remove(curr);
			insertBefore(curr, start);
			start = curr;
			cnt--;
		}
	}

	iterator begin() {
		return iterator(head_->next_);
	}
	iterator end() {
		return iterator(head_);
	}

private:
	ListNode* head_;
	int len_;
};

template<class T>
struct Slist: public LinkList<Slist<T>>::ListNode {
	Slist(T val) :
			val_(val) {
	}
	T val_;
};

int main() {
	LinkList<Slist<int>> L;
	Slist<int> e(0);
	L.add(&e);
	std::string tmp;
	std::vector<int> nums;
	while (std::getline(std::cin, tmp)) {
		std::stringstream ss(tmp);
		int ti;
		while (ss >> ti)
			nums.push_back(ti);
	}
	for (unsigned int i = 0; i < nums.size() / 2; i++) {
		L.add(new Slist<int>(nums[i]));
	}
	for (unsigned int i = nums.size() / 2; i < nums.size(); i++) {
		L.addFirst(new Slist<int>(nums[i]));
	}
	for (auto i : L) {
		std::cout << i.val_ << ' ';
	}
	std::cout << std::endl;
	L.reverseBetween(3, 8);
	L.remove(&e);
	L.reverseBetween(1, L.length());
	//L.reverseBetween(0, L.length());
	return 0;
}

