import {
  Admin,
  Resource,
  ListGuesser,
  EditGuesser,
  ShowGuesser,
} from "react-admin";
import PostIcon from "@mui/icons-material/Book";
import UserIcon from "@mui/icons-material/Group";
import { Layout } from "./Layout";
import { dataProvider } from "./dataProvider";
import { UserList } from "./users";
import { PostCreate, PostEdit, PostList } from "./posts";
import { Dashboard } from "./Dashboard";

export const App = () => (
  <Admin layout={Layout} dataProvider={dataProvider} dashboard={Dashboard}>
    {/* 1. use guesser to quick start */}
    {/* <Resource name="users" list={ListGuesser} /> */}
    <Resource name="users" list={UserList} show={ShowGuesser} icon={UserIcon} />

    {/* <Resource name="posts" list={PostList} /> */}
    <Resource name="posts" list={PostList} show={ShowGuesser} edit={PostEdit} create={PostCreate} icon={PostIcon} />
  </Admin>
);
