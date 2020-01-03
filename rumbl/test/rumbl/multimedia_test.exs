defmodule Rumbl.MultimediaTest do
  use Rumbl.DataCase

  alias Rumbl.Multimedia

  describe "videos" do
    alias Rumbl.Multimedia.Video

    @valid_attrs %{description: "some description", title: "some title", url: "some url"}
    @update_attrs %{
      description: "some updated description",
      title: "some updated title",
      url: "some updated url"
    }
    @invalid_attrs %{description: nil, title: nil, url: nil}

    setup do
      user = user_fixture()

      {:ok, user: user}
    end

    test "list_videos/0 returns all videos", %{user: user} do
      video_fixture(user, @valid_attrs)

      assert Enum.count(Multimedia.list_videos()) == 1
    end

    test "get_video!/1 returns the video with given id", %{user: user} do
      video = video_fixture(user, @valid_attrs)
      stored_video = Multimedia.get_video!(video.id)

      assert stored_video.id == video.id
    end

    test "create_video/1 with valid data creates a video", %{user: user} do
      assert {:ok, %Video{} = video} = Multimedia.create_video(user, @valid_attrs)
      assert video.description == "some description"
      assert video.title == "some title"
      assert video.url == "some url"
    end

    test "create_video/1 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Multimedia.create_video(user, @invalid_attrs)
    end

    test "update_video/2 with valid data updates the video", %{user: user} do
      video = video_fixture(user, @valid_attrs)
      assert {:ok, %Video{} = video} = Multimedia.update_video(video, @update_attrs)
      assert video.description == "some updated description"
      assert video.title == "some updated title"
      assert video.url == "some updated url"
    end

    test "update_video/2 with invalid data returns error changeset", %{user: user} do
      video = video_fixture(user, @valid_attrs)
      stored_video = Multimedia.get_video!(video.id)

      assert {:error, %Ecto.Changeset{}} = Multimedia.update_video(video, @invalid_attrs)
      assert video.id == stored_video.id
    end

    test "delete_video/1 deletes the video", %{user: user} do
      video = video_fixture(user, @valid_attrs)
      assert {:ok, %Video{}} = Multimedia.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Multimedia.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset", %{user: user} do
      video = video_fixture(user, @valid_attrs)
      assert %Ecto.Changeset{} = Multimedia.change_video(video)
    end
  end
end
