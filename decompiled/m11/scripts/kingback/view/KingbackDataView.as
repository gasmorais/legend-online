package kingback.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingback.item.KingbackTabBtn;
   import kingback.page.KingbackDayPage;
   import kingback.page.KingbackGiftPage;
   import kingback.page.KingbackOtherPage;
   import manager.LanguageMgr;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.base.TabPageUtil;
   
   public class KingbackDataView extends Sprite
   {
      
      public var _tabSpanel:ScrollPanel;
      
      public var _rightBack:MutipleImage;
      
      public var _tabVbox:VBox;
      
      public var _btnList:Vector.<KingbackTabBtn>;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _timer:Timer;
      
      public function KingbackDataView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _tabSpanel = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.tabSpanel");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.rightBack");
         _tabVbox = ComponentFactory.Instance.creatCustomObject("ui.kingback.tabVbox");
         addChild(_tabSpanel);
         addChild(_rightBack);
         _tabSpanel.setView(_tabVbox);
         _tabPageUtil = new TabPageUtil();
         initData();
      }
      
      private function initData() : void
      {
         var _loc5_:KingbackTabBtn = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _btnList = new Vector.<KingbackTabBtn>();
         var _loc1_:Array = model.getTypes();
         var _loc2_:int = int(_loc1_ ? _loc1_.length : 0);
         _tabVbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = int(_loc1_[_loc4_]);
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.tabSelectBtn");
            _loc5_.text = LanguageMgr.GetTranslation("kingback.tabBtn.title" + _loc3_);
            _loc5_.type = _loc3_;
            _tabVbox.addChild(_loc5_);
            _btnList.push(_loc5_);
            _tabPageUtil.addItemPage(_loc5_,getFun(_loc3_));
            _loc4_++;
         }
         _tabVbox.commitChanges();
         _tabSpanel.invalidateViewport();
         if(_loc2_ > 0)
         {
            _tabPageUtil.selectIndex = 0;
         }
      }
      
      private function getFun(param1:int) : Function
      {
         switch(param1 - 1)
         {
            case 0:
               return creatDayPage;
            case 1:
               return creatScorePage;
            case 2:
               return creatGiftPage;
            case 3:
               return creatPetHallowsPage;
            case 4:
               return creatArtifactPage;
            case 5:
               return creatGoddessPage;
            case 6:
               return creatPetPage;
            case 7:
               return creatHeroPage;
            default:
               return null;
         }
      }
      
      private function creatDayPage() : KingbackDayPage
      {
         var _loc1_:KingbackDayPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackDayPage");
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatGiftPage() : KingbackGiftPage
      {
         var _loc1_:KingbackGiftPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackGiftPage");
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatScorePage() : KingbackOtherPage
      {
         var _loc1_:KingbackOtherPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackOtherPage",[2]);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatPetHallowsPage() : KingbackOtherPage
      {
         var _loc1_:KingbackOtherPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackOtherPage",[4]);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatArtifactPage() : KingbackOtherPage
      {
         var _loc1_:KingbackOtherPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackOtherPage",[5]);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatGoddessPage() : KingbackOtherPage
      {
         var _loc1_:KingbackOtherPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackOtherPage",[6]);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatPetPage() : KingbackOtherPage
      {
         var _loc1_:KingbackOtherPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackOtherPage",[7]);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatHeroPage() : KingbackOtherPage
      {
         var _loc1_:KingbackOtherPage = ComponentFactory.Instance.creatCustomObject("kingback.page.KingbackOtherPage",[8]);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("kingback.updateInfos",updateInfoHandler);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("kingback.updateInfos",updateInfoHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:Object = _tabPageUtil.selectPage;
         if(_loc2_ && _loc2_.hasOwnProperty("setRemainTime"))
         {
            _loc2_.setRemainTime();
         }
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Object = _tabPageUtil.selectPage;
         if(_loc2_ && _loc2_.hasOwnProperty("refreshView"))
         {
            _loc2_.refreshView();
         }
         for each(var _loc3_:KingbackTabBtn in _btnList)
         {
            _loc3_.refreshIcon();
         }
      }
      
      private function get model() : KingbackModel
      {
         return KingbackManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tabSpanel);
         _tabSpanel = null;
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeObject(_tabVbox);
         _tabVbox = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_btnList);
         _btnList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _timer = null;
      }
   }
}

