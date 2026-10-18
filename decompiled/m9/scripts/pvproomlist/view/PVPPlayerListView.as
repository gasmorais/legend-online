package pvproomlist.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import mvc.controler.PVPRoomListControler;
   import mvc.module.pvproomlist.PVPRoomListModel;
   import org.events.DictionaryEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.PlayerMenu;
   import yishi.view.tips.MessageTipManager;
   
   public class PVPPlayerListView extends Component
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back:Bitmap;
      
      private var _titleTxt:Bitmap;
      
      private var _listPanel:ListPanel;
      
      private var _searchBtn:BaseButton;
      
      private var _createBtn:BaseButton;
      
      private var _quickBtn:BaseButton;
      
      private var _menu:PlayerMenu;
      
      private var _enterTimeBg:Bitmap;
      
      private var _enterTimedes:Bitmap;
      
      private var _enterTimeTxt:FilterFrameText;
      
      private var _clickTime:int;
      
      public function PVPPlayerListView()
      {
         super();
         initView();
         initEvent();
         refreshList();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.PlayerListBack1");
         _back = ComponentFactory.Instance.creatBitmap("asset.pvproomlist.PlayerListBack");
         _titleTxt = ComponentFactory.Instance.creatBitmap("asset.pvproomlist.PlayerTitleTxt");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.PlayerListPanel");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomBtn");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.CreateRoomBtn");
         _quickBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.QuickBtn");
         _enterTimeBg = ComponentFactory.Instance.creatBitmap("asset.water.Expback");
         _enterTimedes = ComponentFactory.Instance.creatBitmap("asset.pvproomlist.TimeLeftBMD");
         _enterTimeTxt = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.roomRight.EnterTimeRecord");
         addChild(_back1);
         addChild(_back);
         addChild(_titleTxt);
         addChild(_listPanel);
         addChild(_searchBtn);
         addChild(_createBtn);
         addChild(_quickBtn);
         addChild(_enterTimeBg);
         _enterTimeBg.x = 33;
         _enterTimeBg.y = 425;
         addChild(_enterTimedes);
         _enterTimedes.x = 57;
         _enterTimedes.y = 452;
         addChild(_enterTimeTxt);
         _enterTimeTxt.x = 134;
         _enterTimeTxt.y = 450;
         _enterTimeTxt.text = PlayerManager.instance.currentPlayerModel.playerInfo.JJCcount + " / " + PlayerManager.instance.currentPlayerModel.playerInfo.JJCMaxCount;
         _listPanel.hScrollProxy = 2;
         _listPanel.vScrollProxy = 0;
         _listPanel.list.verticalUnitIncrement = 20;
      }
      
      private function initEvent() : void
      {
         _createBtn.addEventListener("click",__createRoomHandler);
         _searchBtn.addEventListener("click",__searchRoomHandler);
         _quickBtn.addEventListener("click",__quickClickHandler);
         _listPanel.list.addEventListener("listItemClick",__itemClickHandler);
         PlayerManager.instance.watingList.addEventListener("deleteDictionary",__deletePlayerHandler);
         PlayerManager.instance.watingList.addEventListener("addDictionary",__addPlayerHandler);
      }
      
      private function removeEvent() : void
      {
         _createBtn.removeEventListener("click",__createRoomHandler);
         _searchBtn.removeEventListener("click",__searchRoomHandler);
         _quickBtn.removeEventListener("click",__quickClickHandler);
         _listPanel.list.removeEventListener("listItemClick",__itemClickHandler);
         PlayerManager.instance.watingList.removeEventListener("deleteDictionary",__deletePlayerHandler);
         PlayerManager.instance.watingList.removeEventListener("addDictionary",__addPlayerHandler);
      }
      
      private function refreshList() : void
      {
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.append(thane);
         var _loc1_:Array = PlayerManager.instance.watingList.getList();
         _loc1_.sortOn(["IsVipAndNoExpirt","vocationGrades","grades"],0x10 | 2);
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.grades >= 22)
            {
               _listPanel.vectorListModel.append(_loc2_);
            }
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      private function __addPlayerHandler(param1:DictionaryEvent) : void
      {
         var _loc2_:ThaneInfo = param1.newData;
         if(_loc2_.grades < 22)
         {
            return;
         }
         _listPanel.beginChanges();
         _listPanel.vectorListModel.remove(thane);
         _listPanel.vectorListModel.append(_loc2_);
         _listPanel.vectorListModel.sortOn(["IsVipAndNoExpirt","vocationGrades","grades"],0x10 | 2);
         _listPanel.vectorListModel.append(thane,0);
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      private function __deletePlayerHandler(param1:DictionaryEvent) : void
      {
         var _loc2_:ThaneInfo = param1.oldData;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.remove(_loc2_);
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      private function __itemClickHandler(param1:ListItemEvent) : void
      {
         var _loc2_:ThaneInfo = param1.cellValue;
         if(_loc2_.userId == playerInfo.userId)
         {
            return;
         }
         _menu = new PlayerMenu();
         _menu.setData(_loc2_);
         _menu.x = StageReferance.stage.mouseX + _menu.width >= StageReferance.stageWidth ? StageReferance.stageWidth - _menu.width : Number(StageReferance.stage.mouseX);
         _menu.y = StageReferance.stage.mouseY + _menu.height >= StageReferance.stageHeight ? StageReferance.stageHeight - _menu.height : Number(StageReferance.stage.mouseY);
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      private function __createRoomHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = getTimer();
         if(_loc2_ - _clickTime < 3000)
         {
            return;
         }
         _clickTime = _loc2_;
         var _loc3_:String = WorldBossHelper.getCampaignTips();
         if(_loc3_ != "")
         {
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         control.sendCreateRoom();
      }
      
      private function __searchRoomHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.openSearchFrame();
      }
      
      private function __quickClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.sendSearchRoomInfo(1,0);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : PVPRoomListModel
      {
         return FrameControllerManager.instance.pvpRoomlistControler.model;
      }
      
      private function get control() : PVPRoomListControler
      {
         return FrameControllerManager.instance.pvpRoomlistControler;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

