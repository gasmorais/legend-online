package finaldefense.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import managers.FinalDefenseManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class FinalDefenseSkillItem extends Component
   {
      
      private var _skillBtn:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _skillIndex:int;
      
      private var _txtBg:Bitmap;
      
      private var _skillCountTxt:FilterFrameText;
      
      private var _loader:Loader;
      
      public function FinalDefenseSkillItem(param1:int)
      {
         super();
         _skillIndex = param1;
         initView();
         addEvent();
         updateView();
         loadSkillRes();
      }
      
      private function initView() : void
      {
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__completeHandler);
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.skillbtn" + _skillIndex);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("finaldefense.buySkillbtn");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.SkillCountBg");
         _skillCountTxt = ComponentFactory.Instance.creatComponentByStylename("finaldefens.skillCountTxt");
         addChild(_skillBtn);
         addChild(_buyBtn);
         addChild(_txtBg);
         addChild(_skillCountTxt);
      }
      
      private function loadSkillRes() : void
      {
         var _loc1_:String = PathManager.getFinalDefenseRes("finaldefenceskill1" + (_skillIndex + 1) + "0");
         LoaderManagerII.instance.load(_loc1_,1,8,__onLoaderComplete);
      }
      
      protected function __onLoaderComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_loader)
         {
            return;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loader.loadBytes(param2 as ByteArray,_loc3_);
      }
      
      protected function __completeHandler(param1:Event) : void
      {
         if(_loader == null)
         {
            return;
         }
         _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
         _loader.unloadAndStop(true);
         _loader = null;
      }
      
      private function addEvent() : void
      {
         _buyBtn.addEventListener("click",onBuyBtnClick);
         _skillBtn.addEventListener("click",onSkillClick);
         NotificationManager.instance.addEventListener("FINAL_DEFENSE_USE_SKILL",onUpdateSkillCount);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",onBuyBtnClick);
         _skillBtn.removeEventListener("click",onSkillClick);
         NotificationManager.instance.removeEventListener("FINAL_DEFENSE_USE_SKILL",onUpdateSkillCount);
      }
      
      private function onUpdateSkillCount(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      private function onSkillClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(FinalDefenseManager.ins.model.info["skillCount" + (_skillIndex + 1)]);
         if(_loc2_ > 0)
         {
            FinalDefenseManager.ins.useBuySkill(_skillIndex + 1);
         }
      }
      
      private function onBuyBtnClick(param1:MouseEvent) : void
      {
         FinalDefenseManager.ins.buySkill(_skillIndex + 1);
      }
      
      public function updateView() : void
      {
         _skillCountTxt.text = FinalDefenseManager.ins.model.info["skillCount" + (_skillIndex + 1)];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_skillCountTxt);
         _skillCountTxt = null;
         if(_loader != null)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
            _loader.unloadAndStop(true);
            _loader = null;
         }
         super.dispose();
      }
   }
}

