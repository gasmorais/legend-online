package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetModel;
   
   public class RemotePetFriendView extends Sprite implements Disposeable
   {
      
      private var _listPanel:ListPanel;
      
      private var _onLineFriend:Bitmap;
      
      private var _fightImg:Bitmap;
      
      private var _petInfo:Bitmap;
      
      public function RemotePetFriendView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _onLineFriend = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetFriendView.onLineFriend");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetFriendView.fightImg");
         _petInfo = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetFriendView.petInfo");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendView.ListPanel");
         addChild(_onLineFriend);
         addChild(_fightImg);
         addChild(_petInfo);
         addChild(_listPanel);
      }
      
      private function addEvent() : void
      {
         model.addEventListener("FRIEND_LIST",__listHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("FRIEND_LIST",__listHandler);
      }
      
      private function __listHandler(param1:RemotePetEvent) : void
      {
         refreshList();
      }
      
      private function refreshList() : void
      {
         var _loc2_:int = 0;
         if(!model.friendList)
         {
            return;
         }
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc3_:int = int(model.friendList.length);
         var _loc1_:int = _loc3_;
         if(_loc3_ < 6)
         {
            _loc1_ = 6;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ <= _loc3_ - 1)
            {
               _listPanel.vectorListModel.append(model.friendList[_loc2_]);
            }
            else
            {
               _listPanel.vectorListModel.append(null);
            }
            _loc2_++;
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
         _listPanel.selectFirst();
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_onLineFriend);
         _onLineFriend = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_petInfo);
         _petInfo = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function dispose() : void
      {
         uninitView();
         removeEvent();
      }
   }
}

