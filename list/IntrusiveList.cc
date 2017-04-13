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
				_node(node) {
		}
		iterator& operator ++() {
			if (_node) {
				_node = _node->_next;
			}
			return *this;
		}
		iterator& operator --() {
			if (_node) {
				_node = _node->_prev;
			}
			return *this;
		}
		bool operator ==(const iterator& iter) {
			return _node == iter._node;
		}
		bool operator !=(const iterator& iter) {
			return !operator ==(iter);
		}
		T& operator *() {
			return *static_cast<T*>(_node);
		}

		T* operator ->() {
			return _node;
		}
	private:
		ListNode* _node;
	};

	struct ListNode {
		template<class ... Args>
		ListNode() :
				_list(nullptr), _prev(nullptr), _next(nullptr) {
		}
		LinkList* _list;
		ListNode* _prev;
		ListNode* _next;
	};

	LinkList() :
			_head(new ListNode()), _len(0) {
		_head->_list = this;
		_head->_prev = _head;
		_head->_next = _head;
	}

	~LinkList() {
		ListNode* node = _head->_next;
		while (node != _head) {
			_head->_next = node->_next;
			delete node;
			node = _head->_next;
		}
		delete _head;
	}

	template<class ... Args>
	T* getFirst() {
		return (T*) _head->_next;
	}
	T* getLast() {
		return _head->_prev;
	}
	bool isEmpty() {
		return _len == 0;
	}
	int length() {
		return _len;
	}

	void add(T* t) {
		// append [t] into LinkList.
		_insert(t, _head->_prev);
	}

	void addFirst(T* t) {
		// add [t] at the first.
		_insert(t, _head);
	}

	void insertBefore(T* t, T* at) {
		// Insert [t] before [at].
		_insert(t, ((ListNode*) at)->_prev);
	}

	void insertAfter(T* t, T* at) {
		// Insert [t] after [at].
		_insert(t, at);
	}

	void _insert(T* t, ListNode* at) {
		if (t->_list != nullptr) {
			throw std::runtime_error("ListNode is already in a LinkList.");
		}
		t->_list = this; // Link value into LinkList.
		t->_prev = at;
		t->_next = at->_next;
		at->_next = t;
		t->_next->_prev = t;
		_len++;
	}

	T* remove(T* t) {
		t->_prev->_next = t->_next;
		t->_next->_prev = t->_prev;
		t->_list = nullptr;
		t->_prev = t->_next = nullptr;
		_len--;
		return t;
	}

	void reverseBetween(int m, int n) {
		if (m < 1 || n > _len) {
			std::string str = "Index out of bounds. Wrong range ("
					+ std::to_string(m) + "," + std::to_string(n) + ")";
			throw std::range_error(str);
		}
		int cnt = n - m; // 1 <= m <= n <= LinkList.Length
		T* start = getFirst();
		for (int i = 1; i < m; i++) {
			//start points to the first node to be reversed.
			start = (T*) start->_next;
		}
		T* end = start;
		while (cnt > 0) {
			// Insert nodes from m to n into list.
			T* curr = (T*) end->_next;
			remove(curr);
			insertBefore(curr, start);
			start = curr;
			cnt--;
		}
	}

	iterator begin() {
		return iterator(_head->_next);
	}
	iterator end() {
		return iterator(_head);
	}

private:
	ListNode* _head;
	int _len;
};

template<class T>
struct Slist: public LinkList<Slist<T>>::ListNode {
	Slist(T val) :
			val(val) {
	}
	T val;
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
		std::cout << i.val << ' ';
	}
	std::cout << std::endl;
	L.reverseBetween(3, 8);
	L.remove(&e);
	L.reverseBetween(1, L.length());
	//L.reverseBetween(0, L.length());
	return 0;
}

