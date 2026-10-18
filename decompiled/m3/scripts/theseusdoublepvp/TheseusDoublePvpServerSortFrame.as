package theseusdoublepvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpRankInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpUserInfo;
   import theseusdoublepvp.item.TheseusDoublepvpSortItem;
   import theseusdoublepvp.item.TheseusDoublepvpTopitem;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class TheseusDoublePvpServerSortFrame extends Frame implements IManualSize
   {
      
      public var _sortTitle:Bitmap;
      
      public var _allSTagright:Image;
      
      public var _allSTagLeft:Image;
      
      public var _allsTb1:Image;
      
      public var _allSVbox:VBox;
      
      public var _mysortbg:Bitmap;
      
      public var _allSSortIdx:FilterFrameText;
      
      public var _myItem:TheseusDoublepvpSortItem;
      
      public var _allsTopIt:TheseusDoublepvpTopitem;
      
      private var _allSspanel:ScrollPanel;
      
      private var _lastRankList:Array = [];
      
      private var _selfSortInfo:TheseusDoublePvpRankInfo;
      
      public function TheseusDoublePvpServerSortFrame()
      {
         super();
         initView();
         initEvent();
         TheseusPvpManager.Instance.doSomething1(12);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,878,656);
      }
      
      private function initView() : void
      {
         _sortTitle = ComponentFactory.Instance.creatBitmap("asset.theseus.sortTitle");
         _allSTagright = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allSTagright");
         _allSTagLeft = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allSTagLeft");
         _allsTb1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsTb1");
         _allSVbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.allSVbox");
         _mysortbg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.mysortbg");
         _allSSortIdx = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allSSortIdx");
         _myItem = ComponentFactory.Instance.creatCustomObject("ui.item.TheseusDoublepvpSortItem",[true]);
         _allsTopIt = ComponentFactory.Instance.creatCustomObject("ui.theseusDoublepvp.allsTopIt");
         _allSspanel = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allSspanel");
         addToContent(_allsTb1);
         addToContent(_sortTitle);
         addToContent(_mysortbg);
         addToContent(_allSTagright);
         addToContent(_allSTagLeft);
         addToContent(_allSSortIdx);
         addToContent(_myItem);
         addToContent(_allsTopIt);
         addToContent(_allSspanel);
         _allsTb1.width = 944;
         _allsTb1.height = 600;
         _allSspanel.setView(_allSVbox);
         _allSSortIdx.text = LanguageMgr.GetTranslation("theseuspvp.sortMySt");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("theseusDoublepvpRankEvent",updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("theseusDoublepvpRankEvent",updateHandler);
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:TheseusDoublepvpSortItem = null;
         var _loc5_:TheseusDoublePvpRankInfo = null;
         var _loc3_:int = 0;
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _lastRankList = param1.data as Array;
         _allsTopIt.updataView(_lastRankList);
         _allSVbox.beginChanges();
         _loc3_ = 3;
         while(_loc3_ < _lastRankList.length)
         {
            _loc2_ = new TheseusDoublepvpSortItem();
            _loc5_ = _lastRankList[_loc3_];
            if(_loc4_.nickName == _loc5_.nickName && _loc4_.serviceName == _loc5_.serverName)
            {
               _selfSortInfo = _loc5_;
               _myItem.data = _selfSortInfo;
            }
            _loc2_.data = _loc5_;
            _allSVbox.addChild(_loc2_);
            _loc3_++;
         }
         _allSVbox.commitChanges();
         _allSspanel.invalidateViewport();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      public function show() : void
      {
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc1_:TheseusDoublePvpUserInfo = TheseusPvpManager.Instance.model1.selfUserInfo;
         for each(var _loc3_:TheseusDoublePvpRankInfo in _lastRankList)
         {
            if(_selfSortInfo)
            {
               break;
            }
            if(_loc3_.nickName == _loc2_.nickName && _loc3_.serverName == _loc2_.serviceName)
            {
               _selfSortInfo = _loc3_;
               break;
            }
         }
         if(!_selfSortInfo)
         {
            _selfSortInfo = new TheseusDoublePvpRankInfo();
            _selfSortInfo.rank = _loc1_.rank;
            _selfSortInfo.nickName = _loc2_.nickName;
            _selfSortInfo.serverName = _loc2_.serviceName;
            _selfSortInfo.job = _loc2_.job;
            _selfSortInfo.integral = _loc1_.integral;
            _selfSortInfo.pvpId = _loc1_.pvpId;
         }
         _myItem.data = _selfSortInfo;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_sortTitle);
         _sortTitle = null;
         ObjectUtils.disposeObject(_allSTagright);
         _allSTagright = null;
         ObjectUtils.disposeObject(_allSTagLeft);
         _allSTagLeft = null;
         ObjectUtils.disposeObject(_allsTb1);
         _allsTb1 = null;
         ObjectUtils.disposeObject(_allSVbox);
         _allSVbox = null;
         ObjectUtils.disposeObject(_mysortbg);
         _mysortbg = null;
         ObjectUtils.disposeObject(_allSSortIdx);
         _allSSortIdx = null;
         ObjectUtils.disposeObject(_myItem);
         _myItem = null;
         ObjectUtils.disposeObject(_allsTopIt);
         _allsTopIt = null;
         ObjectUtils.disposeObject(_allSspanel);
         _allSspanel = null;
         super.dispose();
         _lastRankList = null;
      }
   }
}

