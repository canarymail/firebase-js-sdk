Project: /docs/reference/js/_project.yaml
Book: /docs/reference/_book.yaml
page_type: reference

{% comment %}
DO NOT EDIT THIS FILE!
This is generated by the JS SDK team, and any local changes will be
overwritten. Changes should be made in the source code at
https://github.com/firebase/firebase-js-sdk
{% endcomment %}

# FirestoreDataConverter interface
Converter used by `withConverter()` to transform user objects of type `AppModelType` into Firestore data of type `DbModelType`<!-- -->.

Using the converter allows you to specify generic type arguments when storing and retrieving objects from Firestore.

<b>Signature:</b>

```typescript
export declare interface FirestoreDataConverter<AppModelType, DbModelType extends DocumentData = DocumentData> 
```

## Methods

|  Method | Description |
|  --- | --- |
|  [fromFirestore(snapshot, options)](./firestore_.firestoredataconverter.md#firestoredataconverterfromfirestore) | Called by the Firestore SDK to convert Firestore data into an object of type <code>AppModelType</code>. You can access your data by calling: <code>snapshot.data(options)</code>.<!-- -->Generally, the data returned from <code>snapshot.data()</code> can be cast to <code>DbModelType</code>; however, this is not guaranteed as writes to the database may have occurred without a type converter enforcing this specific layout. |
|  [toFirestore(modelObject)](./firestore_.firestoredataconverter.md#firestoredataconvertertofirestore) | Called by the Firestore SDK to convert a custom model object of type <code>AppModelType</code> into a plain JavaScript object (suitable for writing directly to the Firestore database) of type <code>DbModelType</code>. To use <code>set()</code> with <code>merge</code> and <code>mergeFields</code>, <code>toFirestore()</code> must be defined with <code>PartialWithFieldValue&lt;AppModelType&gt;</code>.<!-- -->The <code>WithFieldValue&lt;T&gt;</code> type extends <code>T</code> to also allow FieldValues such as [deleteField()](./firestore_.md#deletefield) to be used as property values. |
|  [toFirestore(modelObject, options)](./firestore_.firestoredataconverter.md#firestoredataconvertertofirestore) | Called by the Firestore SDK to convert a custom model object of type <code>AppModelType</code> into a plain JavaScript object (suitable for writing directly to the Firestore database) of type <code>DbModelType</code>. Used with [setDoc()](./firestore_.md#setdoc)<!-- -->,  and  with <code>merge:true</code> or <code>mergeFields</code>.<!-- -->The <code>PartialWithFieldValue&lt;T&gt;</code> type extends <code>Partial&lt;T&gt;</code> to allow FieldValues such as [arrayUnion()](./firestore_.md#arrayunion) to be used as property values. It also supports nested <code>Partial</code> by allowing nested fields to be omitted. |

## FirestoreDataConverter.fromFirestore()

Called by the Firestore SDK to convert Firestore data into an object of type `AppModelType`<!-- -->. You can access your data by calling: `snapshot.data(options)`<!-- -->.

Generally, the data returned from `snapshot.data()` can be cast to `DbModelType`<!-- -->; however, this is not guaranteed as writes to the database may have occurred without a type converter enforcing this specific layout.

<b>Signature:</b>

```typescript
fromFirestore(snapshot: QueryDocumentSnapshot<DocumentData, DocumentData>, options?: SnapshotOptions): AppModelType;
```

### Parameters

|  Parameter | Type | Description |
|  --- | --- | --- |
|  snapshot | [QueryDocumentSnapshot](./firestore_.querydocumentsnapshot.md#querydocumentsnapshot_class)<!-- -->&lt;[DocumentData](./firestore_.documentdata.md#documentdata_interface)<!-- -->, [DocumentData](./firestore_.documentdata.md#documentdata_interface)<!-- -->&gt; | A <code>QueryDocumentSnapshot</code> containing your data and metadata. |
|  options | [SnapshotOptions](./firestore_.snapshotoptions.md#snapshotoptions_interface) | The <code>SnapshotOptions</code> from the initial call to <code>data()</code>. |

<b>Returns:</b>

AppModelType

## FirestoreDataConverter.toFirestore()

Called by the Firestore SDK to convert a custom model object of type `AppModelType` into a plain JavaScript object (suitable for writing directly to the Firestore database) of type `DbModelType`<!-- -->. To use `set()` with `merge` and `mergeFields`<!-- -->, `toFirestore()` must be defined with `PartialWithFieldValue<AppModelType>`<!-- -->.

The `WithFieldValue<T>` type extends `T` to also allow FieldValues such as [deleteField()](./firestore_.md#deletefield) to be used as property values.

<b>Signature:</b>

```typescript
toFirestore(modelObject: WithFieldValue<AppModelType>): WithFieldValue<DbModelType>;
```

### Parameters

|  Parameter | Type | Description |
|  --- | --- | --- |
|  modelObject | [WithFieldValue](./firestore_.md#withfieldvalue)<!-- -->&lt;AppModelType&gt; |  |

<b>Returns:</b>

[WithFieldValue](./firestore_.md#withfieldvalue)<!-- -->&lt;DbModelType&gt;

## FirestoreDataConverter.toFirestore()

Called by the Firestore SDK to convert a custom model object of type `AppModelType` into a plain JavaScript object (suitable for writing directly to the Firestore database) of type `DbModelType`<!-- -->. Used with [setDoc()](./firestore_.md#setdoc)<!-- -->,  and  with `merge:true` or `mergeFields`<!-- -->.

The `PartialWithFieldValue<T>` type extends `Partial<T>` to allow FieldValues such as [arrayUnion()](./firestore_.md#arrayunion) to be used as property values. It also supports nested `Partial` by allowing nested fields to be omitted.

<b>Signature:</b>

```typescript
toFirestore(modelObject: PartialWithFieldValue<AppModelType>, options: SetOptions): PartialWithFieldValue<DbModelType>;
```

### Parameters

|  Parameter | Type | Description |
|  --- | --- | --- |
|  modelObject | [PartialWithFieldValue](./firestore_.md#partialwithfieldvalue)<!-- -->&lt;AppModelType&gt; |  |
|  options | [SetOptions](./firestore_.md#setoptions) |  |

<b>Returns:</b>

[PartialWithFieldValue](./firestore_.md#partialwithfieldvalue)<!-- -->&lt;DbModelType&gt;

### Example


```typescript
class Post {
  constructor(readonly title: string, readonly author: string) {}

  toString(): string {
    return this.title + ', by ' + this.author;
  }
}

interface PostDbModel {
  title: string;
  author: string;
}

const postConverter = {
  toFirestore(post: WithFieldValue<Post>): PostDbModel {
    return {title: post.title, author: post.author};
  },
  fromFirestore(
    snapshot: QueryDocumentSnapshot,
    options: SnapshotOptions
  ): Post {
    const data = snapshot.data(options) as PostDbModel;
    return new Post(data.title, data.author);
  }
};

const postSnap = await firebase.firestore()
  .collection('posts')
  .withConverter(postConverter)
  .doc().get();
const post = postSnap.data();
if (post !== undefined) {
  post.title; // string
  post.toString(); // Should be defined
  post.someNonExistentProperty; // TS error
}

```
