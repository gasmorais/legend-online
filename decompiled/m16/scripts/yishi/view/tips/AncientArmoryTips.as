package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.ArtifactEquipItem;
   
   public class AncientArmoryTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _itemIcon:BaseIconView;
      
      private var _name:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _profileImg:ScaleFrameImage;
      
      public function AncientArmoryTips()
      {
         super();
         _bg.width = 255;
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _name.width = 180;
         _name.y = 5;
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.armoryGradeTxt");
         _describe = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryDescTipsTxt");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.armoryTotalBox");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         _describe.width = 212;
         _totalBox.x = 10;
         _totalBox.y = 58;
         _totalBox.spacing = 4;
         addChild(_name);
         addChild(_gradeTxt);
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc8_:Bitmap = null;
         var _loc13_:AncientArmoryInfo = null;
         var _loc10_:int = 0;
         var _loc12_:ArmoryTemplateInfo = null;
         var _loc7_:Array = null;
         var _loc11_:Array = null;
         var _loc9_:int = 0;
         var _loc2_:ArtifactEquipItem = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Bitmap = null;
         if(tipData)
         {
            ObjectUtils.disposeAllChildren(_totalBox);
            _totalBox.beginChanges();
            _loc8_ = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
            _loc8_.width = 215;
            _totalBox.addChild(_loc8_);
            _loc13_ = tipData as AncientArmoryInfo;
            _loc10_ = int(_loc13_.grades);
            _itemIcon.icon = IconFactory.getArmoryIconPath(_loc13_.templateId,_loc13_.profile);
            _loc12_ = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_loc13_.templateId,_loc13_.profile);
            _name.text = _loc12_.TemplateName;
            _name.setFrame(_loc13_.profile + 1);
            _gradeTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTips",_loc13_.grades);
            _loc7_ = ["Attacks","PhyDefence","MagicDefence","Live","Parry","Penetrate"];
            _loc11_ = ["AttackAdd","PhyDefenceAdd","MagicDefenceAdd","LiveAdd","ParryAdd","PenetrateAdd"];
            _loc9_ = int(_loc7_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc9_)
            {
               _loc3_ = int(_loc12_[_loc7_[_loc4_]]);
               _loc1_ = int(_loc12_[_loc11_[_loc4_]]) * _loc10_;
               if(_loc3_ > 0)
               {
                  _loc5_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTxt0" + (_loc4_ + 1));
                  _loc2_ = new ArtifactEquipItem();
                  _loc2_.updateText(_loc5_,_loc3_ + _loc1_);
                  _totalBox.addChild(_loc2_);
               }
               _loc4_ += 1;
            }
            _describe.htmlText = _loc12_.Desc;
            setProfile(_loc13_.profile);
            _loc6_ = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
            _loc6_.width = 215;
            _totalBox.addChild(_loc6_);
            _totalBox.addChild(_describe);
            _totalBox.commitChanges();
            _bg.height = _totalBox.y + _totalBox.height + 10;
            _redBg.height = _bg.height;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _redBg.width = _bg.width;
            _yellowBg.width = _bg.width;
            _purpleBg.width = _bg.width;
            _blueBg.width = _bg.width;
            _greenBg.width = _bg.width;
            _whiteBg.width = _bg.width;
            _redBg.y = _bg.y - 3;
            _yellowBg.y = _bg.y - 3;
            _purpleBg.y = _bg.y - 3;
            _blueBg.y = _bg.y - 3;
            _greenBg.y = _bg.y - 3;
            _whiteBg.y = _bg.y - 3;
         }
      }
      
      private function setProfile(param1:int) : void
      {
         _bg.visible = false;
         _redBg.visible = _yellowBg.visible = _purpleBg.visible = _blueBg.visible = _greenBg.visible = _whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _greenBg.visible = true;
               _profileImg.setFrame(2);
               break;
            case 1:
               _blueBg.visible = true;
               _profileImg.setFrame(3);
               break;
            case 2:
               _purpleBg.visible = true;
               _profileImg.setFrame(4);
               break;
            case 3:
               _yellowBg.visible = true;
               _profileImg.setFrame(5);
               break;
            case 4:
               _redBg.visible = true;
               _profileImg.setFrame(6);
         }
      }
      
      override public function dispose() : void
      {
         if(_redBg)
         {
            ObjectUtils.disposeObject(_redBg);
         }
         _redBg = null;
         if(_yellowBg)
         {
            ObjectUtils.disposeObject(_yellowBg);
         }
         _yellowBg = null;
         if(_purpleBg)
         {
            ObjectUtils.disposeObject(_purpleBg);
         }
         _purpleBg = null;
         if(_blueBg)
         {
            ObjectUtils.disposeObject(_blueBg);
         }
         _blueBg = null;
         if(_greenBg)
         {
            ObjectUtils.disposeObject(_greenBg);
         }
         _greenBg = null;
         if(_whiteBg)
         {
            ObjectUtils.disposeObject(_whiteBg);
         }
         _whiteBg = null;
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

