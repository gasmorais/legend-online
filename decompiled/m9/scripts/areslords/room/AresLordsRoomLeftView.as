package areslords.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.areslords.AresLordsPlayerInfo;
   import mvc.module.areslords.AresLordsRoomInfo;
   
   public class AresLordsRoomLeftView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _title:ScaleBitmapImage;
      
      private var _medal:ScaleFrameImage;
      
      private var _group:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _split:ScaleBitmapImage;
      
      private var _list:ListPanel;
      
      private var _myRank:FilterFrameText;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _myPoint:FilterFrameText;
      
      private var _myPointTxt:FilterFrameText;
      
      private var _rankList:Vector.<AresLordsPlayerInfo>;
      
      private var _currentTab:int = -1;
      
      private var _maxTab:int = 5;
      
      private var _tabPreBtn:BaseButton;
      
      private var _tabNextBtn:BaseButton;
      
      public function AresLordsRoomLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftBgBorder");
         _title = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftTitle");
         _medal = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftMedal");
         _group = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftGroup");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftRank");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftName");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftPoint");
         _split = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftSplit");
         _list = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftList");
         _myRank = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftMyRank");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftMyRankTxt");
         _myPoint = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftMyPoint");
         _myPointTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftMyPointTxt");
         _tabPreBtn = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftPagePreBtn");
         _tabNextBtn = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftPageNextBtn");
         addChild(_bg);
         addChild(_title);
         addChild(_medal);
         addChild(_group);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_pointTxt);
         addChild(_split);
         addChild(_list);
         addChild(_myRank);
         addChild(_myRankTxt);
         addChild(_myPoint);
         addChild(_myPointTxt);
         addChild(_tabPreBtn);
         addChild(_tabNextBtn);
         _rankTxt.text = LanguageMgr.GetTranslation("areslords.Room.Left.str01");
         _nameTxt.text = LanguageMgr.GetTranslation("areslords.Room.Left.str02");
         _pointTxt.text = LanguageMgr.GetTranslation("areslords.Room.Left.str03");
         _myRank.text = LanguageMgr.GetTranslation("areslords.Room.Left.str04");
         _myPoint.text = LanguageMgr.GetTranslation("areslords.Room.Left.str05");
      }
      
      private function addEvent() : void
      {
         _tabPreBtn.addEventListener("click",__tabPreBtnClickHandler);
         _tabNextBtn.addEventListener("click",__tabNextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _tabPreBtn.removeEventListener("click",__tabPreBtnClickHandler);
         _tabNextBtn.removeEventListener("click",__tabNextBtnClickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_split);
         _split = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_myRank);
         _myRank = null;
         ObjectUtils.disposeObject(_myRankTxt);
         _myRankTxt = null;
         ObjectUtils.disposeObject(_myPoint);
         _myPoint = null;
         ObjectUtils.disposeObject(_myPointTxt);
         _myPointTxt = null;
         ObjectUtils.disposeObject(_tabPreBtn);
         _tabPreBtn = null;
         ObjectUtils.disposeObject(_tabNextBtn);
         _tabNextBtn = null;
         _rankList = null;
         super.dispose();
      }
      
      public function set data(param1:AresLordsRoomInfo) : void
      {
         var _loc2_:String = null;
         if(param1.order)
         {
            _loc2_ = LanguageMgr.GetTranslation("areslords.GroupName." + (param1.teamType + 1));
            _myRankTxt.text = LanguageMgr.GetTranslation("areslords.Room.Left.str06",_loc2_,param1.order + "");
         }
         else
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("areslords.Room.Left.str07");
         }
         _myPointTxt.text = param1.totalScore + "";
         _rankList = param1.rankList;
         if(_currentTab == -1)
         {
            currentTab = param1.teamType;
         }
         else
         {
            currentTab = _currentTab;
         }
      }
      
      private function refreshList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:Vector.<AresLordsPlayerInfo> = _rankList.filter(filterRankByTab);
         _loc3_.sort(sortByRank);
         _list.vectorListModel.clear();
         _loc2_ = 0;
         _loc1_ = int(_loc3_.length);
         while(_loc2_ < _loc1_)
         {
            _list.vectorListModel.append(_loc3_[_loc2_]);
            _loc2_++;
         }
         _list.list.updateListView();
      }
      
      private function filterRankByTab(param1:Object, param2:int, param3:*) : Boolean
      {
         return param1.teamType == _currentTab;
      }
      
      private function sortByRank(param1:Object, param2:Object) : int
      {
         if(param1.rankOrder < param2.rankOrder)
         {
            return -1;
         }
         if(param1.rankOrder > param2.rankOrder)
         {
            return 1;
         }
         return 0;
      }
      
      private function __tabPreBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.max(0,_currentTab - 1);
         if(_loc2_ != _currentTab)
         {
            currentTab = _loc2_;
         }
      }
      
      private function __tabNextBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.min(_maxTab,_currentTab + 1);
         if(_loc2_ != _currentTab)
         {
            currentTab = _loc2_;
         }
      }
      
      private function set currentTab(param1:int) : void
      {
         _currentTab = param1;
         _medal.setFrame(_currentTab + 1);
         _group.setFrame(_currentTab + 1);
         _tabPreBtn.enable = _currentTab != 0;
         _tabNextBtn.enable = _currentTab != _maxTab;
         refreshList();
      }
   }
}

