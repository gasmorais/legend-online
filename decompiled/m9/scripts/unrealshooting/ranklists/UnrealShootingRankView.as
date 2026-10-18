package unrealshooting.ranklists
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.data.UnrealShootingUserInfo;
   import map.campaign.event.UnrealShootingEvent;
   import utils.LogicUtils;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingRankView extends Component
   {
      
      private var _bg:Image;
      
      private var _sort:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _fightPower:FilterFrameText;
      
      private var _selfBg:MutipleImage;
      
      private var _prePageBtn:IconButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _nextPageBtn:IconButton;
      
      private var _selfItem:UnrealShootingRankItem;
      
      private var _vBox:VBox;
      
      private var _itemArr:Array;
      
      private var _curPage:int = 1;
      
      private var _model:UnrealShootingModel = FrameControllerManager.instance.unrealShootingController.model;
      
      private const PAGE_NUM:int = 10;
      
      public function UnrealShootingRankView()
      {
         super();
         initView();
         addEvent();
         FrameControllerManager.instance.unrealShootingController.sendUnrealShootingWeekOrderQuery();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:UnrealShootingRankItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.bg");
         _sort = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.sort");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.nickName");
         _server = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.server");
         _score = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.score");
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.fightPower");
         _selfBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.selfBg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.preBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.pagebg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.pageTxt");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankView.nextBtn");
         _vBox = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRankView.vbox");
         _selfItem = new UnrealShootingRankItem(true);
         _selfItem.y = 35;
         addChild(_bg);
         addChild(_sort);
         addChild(_nickName);
         addChild(_server);
         addChild(_score);
         addChild(_fightPower);
         addChild(_selfBg);
         addChild(_prePageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         addChild(_nextPageBtn);
         addChild(_selfItem);
         addChild(_vBox);
         _itemArr = [];
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new UnrealShootingRankItem();
            _vBox.addChild(_loc1_);
            _itemArr.push(_loc1_);
            _loc2_++;
         }
         _sort.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.sort");
         _nickName.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.nickName");
         _server.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.server");
         _score.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.score");
         _fightPower.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.fightPower");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sort);
         _sort = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_server);
         _server = null;
         ObjectUtils.disposeObject(_score);
         _score = null;
         ObjectUtils.disposeObject(_fightPower);
         _fightPower = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_selfItem);
         _selfItem = null;
         ObjectUtils.disposeObject(_selfBg);
         _selfBg = null;
         LogicUtils.disposeDisplayCollection(_itemArr);
         _itemArr = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
      
      private function addEvent() : void
      {
         _prePageBtn.addEventListener("click",__pageBtnClickHandler);
         _nextPageBtn.addEventListener("click",__pageBtnClickHandler);
         _model.addEventListener("UNREAL_SHOOTING_FINAL_ORDER_LIST_CHANGE",__listChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__pageBtnClickHandler);
         _nextPageBtn.removeEventListener("click",__pageBtnClickHandler);
         _model.removeEventListener("UNREAL_SHOOTING_FINAL_ORDER_LIST_CHANGE",__listChangeHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __listChangeHandler(param1:UnrealShootingEvent) : void
      {
         refreshView();
      }
      
      private function __pageBtnClickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _prePageBtn)
         {
            _curPage = _curPage - 1;
         }
         if(param1.target == _nextPageBtn)
         {
            _curPage = _curPage + 1;
         }
         refreshView();
      }
      
      private function get totalPage() : int
      {
         return Math.ceil(_model.finalOrderList.length / 10);
      }
      
      private function refreshView() : void
      {
         var _loc2_:UnrealShootingUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 10 * (_curPage - 1);
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc3_ = _loc1_ + _loc4_;
            _loc2_ = _model.finalOrderList[_loc3_];
            (_itemArr[_loc4_] as UnrealShootingRankItem).data = _loc2_;
            _loc4_++;
         }
         _prePageBtn.enable = _curPage > 1;
         _nextPageBtn.enable = _curPage < totalPage;
         _pageTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankView.page",_curPage,totalPage > 0 ? totalPage : 1);
         _selfItem.data = _model.myRankInfo;
      }
   }
}

