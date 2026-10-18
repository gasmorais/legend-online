package monsterexplore.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import mvc.module.monsterexplore.MonsterExploreFormationInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   
   public class MonsterExploreInfoItem extends Component
   {
      
      private var _headBack:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _nameBack:Bitmap;
      
      private var _gradeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _expBar:ProgressCommon;
      
      private var _captainImage:Bitmap;
      
      private var _addBtn:BaseButton;
      
      private var index:int;
      
      private var _data:MonsterExploreFormationInfo;
      
      private var monsterInfo:MonsterInfo;
      
      public function MonsterExploreInfoItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _headBack = ComponentFactory.Instance.creatBitmap("asset.MonsterFormationSelectItem.back");
         _headIcon = ComponentFactory.Instance.creatCustomObject("MonsterExploreInfoItem.headIcon");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreInfoItem.gradeText");
         _nameBack = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreInfoItem.nameBack");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreInfoItem.nameText");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreInfoItem.expBar");
         _captainImage = ComponentFactory.Instance.creatBitmap("asset.MonsterFormationSelectItem.captainBit");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFormationSelectItem.addBtn");
         addChild(_headIcon);
         addChild(_headBack);
         addChild(_addBtn);
         addChild(_captainImage);
         addChild(_gradeText);
         addChild(_nameBack);
         addChild(_nameText);
         addChild(_expBar);
      }
      
      private function addEvent() : void
      {
         _addBtn.addEventListener("click",__addClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addClickHandler);
         }
      }
      
      private function __addClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("monsterexplore","FORMATION_FRAME");
      }
      
      public function get data() : MonsterExploreFormationInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterExploreFormationInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         clean();
         if(data)
         {
            _expBar.visible = true;
            _nameBack.visible = true;
            _addBtn.visible = false;
            monsterInfo = data.monsterInfo;
            if(monsterInfo)
            {
               _headIcon.icon = IconFactory.getCommonIconPath(monsterInfo.tempInfo.Icon);
               _headIcon.tipData = monsterInfo;
               _nameText.text = monsterInfo.name;
               _gradeText.text = LanguageMgr.GetTranslation("public.level2",monsterInfo.grade);
               _nameText.y = _nameText.numLines > 1 ? 22 : 29;
               _captainImage.visible = data.isCaptain;
               _loc2_ = int(model.getNextGradeExp(monsterInfo));
               if(monsterInfo.grade >= monsterInfo.tempInfo.MaxLevel)
               {
                  _expBar.value = 1;
                  _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
               }
               else
               {
                  _expBar.value = monsterInfo.curExp / _loc2_;
                  _expBar.text = LanguageMgr.GetTranslation("MonsterExploreInfoItem.expBar.text",monsterInfo.curExp,_loc2_);
               }
            }
         }
      }
      
      private function clean() : void
      {
         _headIcon.icon = null;
         _headIcon.tipData = null;
         _nameText.text = "";
         _gradeText.text = "";
         _expBar.value = 0;
         _expBar.text = "";
         _captainImage.visible = false;
         _expBar.visible = false;
         _nameBack.visible = false;
         _addBtn.visible = true;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_captainImage);
         _captainImage = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         super.dispose();
      }
   }
}

