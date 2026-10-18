package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class MonsterTips extends BaseTip
   {
      
      protected var _whiteBg:Scale9CornerImage;
      
      protected var _totalBox:VBox;
      
      private var _headIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _fightText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _gradeAlertText:FilterFrameText;
      
      private var _starHbox:HBox;
      
      private var propList:Vector.<ArtifactEquipItem>;
      
      private var _attributeLine:Bitmap;
      
      private var _fightLine:Bitmap;
      
      private var propLen:int = 8;
      
      private var preStar:int;
      
      public function MonsterTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ArtifactEquipItem = null;
         super.init();
         _bg.width = 380;
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _headIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _attributeLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _fightLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodIntensifyText_2");
         _gradeAlertText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodIntensifyText_2");
         _fightText = ComponentFactory.Instance.creatComponentByStylename("MonsterTips.fightText");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterTips.starHbox");
         addChild(_whiteBg);
         addChild(_headIcon);
         addChild(_profileImg);
         addChild(_title);
         addChild(_starHbox);
         addChild(_type);
         addChild(_gradeText);
         addChild(_gradeAlertText);
         addChild(_totalBox);
         _totalBox.addChild(_attributeLine);
         propList = new Vector.<ArtifactEquipItem>();
         _loc2_ = 0;
         while(_loc2_ < propLen)
         {
            _loc1_ = new ArtifactEquipItem();
            _loc1_.updateText(getPropStrByIndex(_loc2_),0);
            _totalBox.addChild(_loc1_);
            propList.push(_loc1_);
            _loc2_++;
         }
         _totalBox.addChild(_fightLine);
         _totalBox.addChild(_fightText);
         _title.x = 65;
         _type.x = 1;
         _type.y = 55;
         _whiteBg.x = -10;
         _totalBox.y = 97;
         _gradeText.x = 130;
         _gradeText.y = 55;
         _gradeAlertText.x = 130;
         _gradeAlertText.y = 75;
         _profileImg.setFrame(1);
         _type.text = LanguageMgr.GetTranslation("MonsterFrame.title.text");
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:MonsterInfo = null;
         var _loc5_:int = 0;
         var _loc2_:ArtifactEquipItem = null;
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Bitmap = null;
         if(tipData)
         {
            _totalBox.beginChanges();
            _bg.visible = false;
            _loc3_ = tipData as MonsterInfo;
            _headIcon.icon = IconFactory.getCommonIconPath(_loc3_.tempInfo.Icon);
            _title.text = _loc3_.name;
            _title.setFrame(1);
            _fightText.htmlText = LanguageMgr.GetTranslation("ChildNursingSpiritItem.fightText.text",_loc3_.fightPower);
            _gradeText.text = LanguageMgr.GetTranslation("public.level2",_loc3_.grade);
            _gradeAlertText.text = LanguageMgr.GetTranslation("MonsterTips.gradeAlertText.text",_loc3_.tempInfo.MaxLevel);
            _loc5_ = 0;
            while(_loc5_ < propLen)
            {
               _loc2_ = propList[_loc5_];
               _loc4_ = getPropStrByIndex(_loc5_);
               _loc7_ = model.getPropValueByIndex(_loc5_,_loc3_);
               _loc2_.updateText(_loc4_,_loc7_);
               _loc5_++;
            }
            if(preStar != _loc3_.star)
            {
               _starHbox.removeAllChild();
               _loc6_ = 0;
               while(_loc6_ < _loc3_.star)
               {
                  _loc1_ = ComponentFactory.Instance.creatBitmap("asset.monster.StarTipsImg");
                  _starHbox.addChild(_loc1_);
                  _loc6_++;
               }
            }
            preStar = _loc3_.star;
            _totalBox.commitChanges();
            _bg.height = int(-_bg.y + _totalBox.y + _totalBox.height + 10);
            _whiteBg.height = _bg.height;
            _whiteBg.width = 380;
         }
      }
      
      private function getPropStrByIndex(param1:int) : String
      {
         var _loc2_:int = 40 + param1;
         return LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip" + _loc2_);
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_whiteBg);
         _whiteBg = null;
         ObjectUtils.disposeObject(_totalBox);
         _totalBox = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_type);
         _type = null;
         ObjectUtils.disposeObject(_fightLine);
         _fightLine = null;
         ObjectUtils.disposeObject(_attributeLine);
         _attributeLine = null;
         ObjectUtils.disposeObject(_fightText);
         _whiteBg = null;
         ObjectUtils.disposeObject(_gradeAlertText);
         _gradeAlertText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         LogicUtils.disposeDisplayCollection(propList);
         propList = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

