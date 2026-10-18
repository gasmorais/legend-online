package consortia.view.myConsortia.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class ConsortiaSkillNewItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _selectImage:Bitmap;
      
      private var _skillIcon:BaseIconView;
      
      private var _nameText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _tempInfo:ConsortiaTemplete;
      
      private var viewType:int;
      
      public function ConsortiaSkillNewItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.ConsortiaSkillNewItem.back");
         _selectImage = ComponentFactory.Instance.creatBitmap("asset.ConsortiaSkillNewItem.selectImage");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("ConsortiaSkillNewItem.skillIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillNewItem.nameText");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillNewItem.gradeText");
         addChild(_back);
         addChild(_selectImage);
         addChild(_skillIcon);
         addChild(_gradeText);
         addChild(_nameText);
         _selectImage.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__onSkillIconSelectHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__onSkillIconSelectHandler);
      }
      
      private function __onSkillIconSelectHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("SKILL_ICON_SELECT",tempInfo);
      }
      
      public function get tempInfo() : ConsortiaTemplete
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:ConsortiaTemplete) : void
      {
         _tempInfo = param1;
         _skillIcon.icon = IconFactory.getTecIconByIcon(tempInfo.Icon);
         var _loc2_:int = int(consortiaInfo.getLevelByUpgradeType(tempInfo.Types));
         var _loc4_:int = int(ConsortiaSkillHelper.getLevelByType(tempInfo.Types,playerInfo));
         var _loc3_:int = viewType == 1 ? _loc2_ : _loc4_;
         var _loc5_:ConsortiaTemplete = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(tempInfo.Types,_loc3_);
         _gradeText.text = LanguageMgr.GetTranslation("public.level2",_loc3_);
         _nameText.text = _loc5_ ? _loc5_.LevelName : tempInfo.LevelName;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectImage.visible = param1;
      }
      
      public function setViewType(param1:int) : void
      {
         viewType = param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return model.consortiaInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_selectImage);
         _selectImage = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         super.dispose();
      }
   }
}

