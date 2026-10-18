package battle.view.bottom
{
   import battle.view.ui.PetSkillItemListView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.BattleModel;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.TimerUtils;
   
   public class PetBattleBar extends Sprite
   {
      
      private var _back:Bitmap;
      
      private var _skillList:PetSkillItemListView;
      
      private var _battleModel:BattleModel;
      
      private var _ballRotate:Boolean;
      
      private var _settingBtn:BaseButton;
      
      public function PetBattleBar(param1:Boolean = true)
      {
         super();
         _ballRotate = param1;
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.remotepetBack");
         _back.x = -_back.width * 0.5;
         _back.y = -_back.height;
         addChild(_back);
         _skillList = new PetSkillItemListView();
         _skillList.x = -300;
         _skillList.y = -68;
         addChild(_skillList);
         _settingBtn = ComponentFactory.Instance.creatComponentByStylename("battle.settingBtn");
         addChild(_settingBtn);
         _settingBtn.tipData = LanguageMgr.GetTranslation("battle.view.bottom.BottomBar.settingBtn.tipData");
         addEvent();
      }
      
      private function addEvent() : void
      {
         if(_settingBtn)
         {
            _settingBtn.addEventListener("click",onSettingBtnClick);
         }
      }
      
      public function getSkillList() : PetSkillItemListView
      {
         return _skillList;
      }
      
      private function onSettingBtnClick(param1:MouseEvent) : void
      {
         TimerUtils.setTimeout(openFrame,10);
      }
      
      private function openFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("setting");
      }
      
      private function removeEvent() : void
      {
         if(_settingBtn)
         {
            _settingBtn.removeEventListener("click",onSettingBtnClick);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_settingBtn);
         _settingBtn = null;
         ObjectUtils.disposeObject(_skillList);
         _skillList = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

