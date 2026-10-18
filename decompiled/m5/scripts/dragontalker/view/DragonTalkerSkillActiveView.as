package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerSkillActiveView extends Component
   {
      
      private var _activeBack:MutipleImage;
      
      private var _lookDetailBtn2:IconButton;
      
      private var _lookDetailBtn1:IconButton;
      
      private var _activeBtn2:IconButton;
      
      private var _activeBtn1:IconButton;
      
      private var _skillDesc2:FilterFrameText;
      
      private var _skillDesc1:FilterFrameText;
      
      public function DragonTalkerSkillActiveView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _lookDetailBtn2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuaa.lookDetailBtn2");
         _lookDetailBtn1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuaa.lookDetailBtn1");
         _activeBtn2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuaa.activeBtn2");
         _activeBtn1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuaa.activeBtn1");
         _activeBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuaa.activeBack");
         _skillDesc2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n4_vhuavhuaa");
         _skillDesc1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n2_vhuavhuaa");
         addChild(_activeBack);
         addChild(_skillDesc1);
         addChild(_skillDesc2);
         addChild(_activeBtn1);
         addChild(_activeBtn2);
         addChild(_lookDetailBtn1);
         addChild(_lookDetailBtn2);
         _skillDesc1.text = LanguageMgr.GetTranslation("DragonTalker.skillDesc1.text");
         _skillDesc2.text = LanguageMgr.GetTranslation("DragonTalker.skillDesc2.text");
      }
      
      private function addEvent() : void
      {
         _lookDetailBtn2.addEventListener("click",clicklookDetailBtn2Handler);
         _lookDetailBtn1.addEventListener("click",clicklookDetailBtn1Handler);
         _activeBtn2.addEventListener("click",clickactiveBtn2Handler);
         _activeBtn1.addEventListener("click",clickactiveBtn1Handler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSkillViewHandler);
      }
      
      private function clickactiveBtn1Handler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.skillActiveIndex == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerSkillActiveView.hasActive.alert"));
            return;
         }
         DragonTalkerManager.instance.sendSkillRequest(10,1);
      }
      
      private function clickactiveBtn2Handler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.skillActiveIndex == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerSkillActiveView.hasActive.alert"));
            return;
         }
         DragonTalkerManager.instance.sendSkillRequest(10,2);
      }
      
      private function clicklookDetailBtn1Handler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         model.skillTabIndex = 1;
      }
      
      private function clicklookDetailBtn2Handler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         model.skillTabIndex = 2;
      }
      
      private function removeEvent() : void
      {
         if(_lookDetailBtn1)
         {
            _lookDetailBtn1.removeEventListener("click",clicklookDetailBtn1Handler);
         }
         if(_lookDetailBtn2)
         {
            _lookDetailBtn2.removeEventListener("click",clicklookDetailBtn2Handler);
         }
         if(_activeBtn1)
         {
            _activeBtn1.removeEventListener("click",clickactiveBtn1Handler);
         }
         if(_activeBtn2)
         {
            _activeBtn2.removeEventListener("click",clickactiveBtn2Handler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSkillViewHandler);
      }
      
      private function __updateSkillViewHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(model.skillActiveIndex == 1)
         {
            _activeBtn1.iconStyle = "asset.DragonTalkerSkillActiveView.hasActiveImage";
            _activeBtn1.iconInnerRectString = "46,68,10,33,13";
            _activeBtn2.iconStyle = "asset.DragonTalker.resource.skill.vhuah";
            _activeBtn2.iconInnerRectString = "46,57,10,33,13";
         }
         else if(model.skillActiveIndex == 2)
         {
            _activeBtn1.iconStyle = "asset.DragonTalker.resource.skill.vhuah";
            _activeBtn1.iconInnerRectString = "46,57,10,33,13";
            _activeBtn2.iconStyle = "asset.DragonTalkerSkillActiveView.hasActiveImage";
            _activeBtn2.iconInnerRectString = "46,68,10,33,13";
         }
         else
         {
            _activeBtn1.iconStyle = "asset.DragonTalker.resource.skill.vhuah";
            _activeBtn1.iconInnerRectString = "46,57,10,33,13";
            _activeBtn2.iconStyle = "asset.DragonTalker.resource.skill.vhuah";
            _activeBtn2.iconInnerRectString = "46,57,10,33,13";
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lookDetailBtn2);
         _lookDetailBtn2 = null;
         ObjectUtils.disposeObject(_lookDetailBtn1);
         _lookDetailBtn1 = null;
         ObjectUtils.disposeObject(_activeBtn2);
         _activeBtn2 = null;
         ObjectUtils.disposeObject(_activeBtn1);
         _activeBtn1 = null;
         ObjectUtils.disposeObject(_activeBack);
         _activeBack = null;
         ObjectUtils.disposeObject(_skillDesc2);
         _skillDesc2 = null;
         ObjectUtils.disposeObject(_skillDesc1);
         _skillDesc1 = null;
         super.dispose();
      }
   }
}

