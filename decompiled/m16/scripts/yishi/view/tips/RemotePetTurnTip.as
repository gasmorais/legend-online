package yishi.view.tips
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
   import mvc.module.remotepet.RemotePetTurnItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class RemotePetTurnTip extends BaseTip
   {
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _index:FilterFrameText;
      
      private var _typeIcon:ScaleFrameImage;
      
      private var _headIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _vBox:VBox;
      
      private var _line01:Bitmap;
      
      private var _line02:Bitmap;
      
      private var _dropTxt:FilterFrameText;
      
      private var _dropHox:HBox;
      
      private var _fristTxt:FilterFrameText;
      
      private var _fristHox:HBox;
      
      private var _skillTxt:FilterFrameText;
      
      private var _mopupValue:FilterFrameText;
      
      public function RemotePetTurnTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.nameTxt");
         _index = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.indexTxt");
         _typeIcon = ComponentFactory.Instance.creatComponentByStylename("petTip.PetTypeImage");
         _headIcon = ComponentFactory.Instance.creatCustomObject("petTip.headIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _profileImg.x = 10;
         _profileImg.y = 10;
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.vBox");
         _line02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _dropTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.dropTxt");
         _dropHox = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.dropHox");
         _fristTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.fristTxt");
         _fristHox = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.fristHox");
         _skillTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.skillTxt");
         _mopupValue = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.mopupValue");
         _line01.width = 280;
         _line02.width = 280;
         addChild(_purpleBg);
         addChild(_nameTxt);
         _nameTxt.multiline = true;
         _nameTxt.wordWrap = true;
         _nameTxt.height = 40;
         addChild(_index);
         addChild(_typeIcon);
         addChild(_headIcon);
         addChild(_profileImg);
         _profileImg.setFrame(4);
         addChild(_line01);
         _line01.y = 85;
         addChild(_vBox);
         _dropTxt.text = LanguageMgr.GetTranslation("RemotePetTurnTip.dropTxt");
         _fristTxt.text = LanguageMgr.GetTranslation("RemotePetTurnTip.fristTxt");
         _bg.width = 320;
         _purpleBg.width = _bg.width;
         _bg.visible = false;
      }
      
      override protected function updateTransform() : void
      {
         var _loc7_:RemotePetTurnItemInfo = null;
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc2_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:SkillTempInfo = null;
         clean();
         if(_data is RemotePetTurnItemInfo)
         {
            if(_dropHox)
            {
               _dropHox.removeAllChild();
            }
            if(_fristHox)
            {
               _fristHox.removeAllChild();
            }
            _loc7_ = _data as RemotePetTurnItemInfo;
            _nameTxt.text = _loc7_.tempInfo.Name;
            _nameTxt.setFrame(4);
            _loc5_ = int(_loc7_.tempInfo.Property);
            _typeIcon.setFrame(_loc5_);
            _headIcon.icon = IconFactory.getCommonIconPath(_loc7_.tempInfo.Icon2);
            if(_loc7_.tempInfo.Type == 1)
            {
               _index.text = LanguageMgr.GetTranslation("RemotePetTurnTip.index",_loc7_.tempInfo.Index);
               _vBox.addChild(_dropTxt);
               if(_loc7_.tempInfo.DropItems)
               {
                  for each(var _loc3_:String in _loc7_.tempInfo.DropItems.split(","))
                  {
                     if(_loc3_)
                     {
                        _loc1_ = _loc3_.split("|");
                        _loc2_ = ComponentFactory.Instance.creatCustomObject("RemotePetTurnTip.dropItem");
                        _loc6_ = new GoodsInfo();
                        _loc6_.templateId = _loc1_[0];
                        _loc6_.count = _loc1_[1];
                        _loc2_.data = _loc6_;
                        _dropHox.addChild(_loc2_);
                     }
                  }
               }
               _vBox.addChild(_dropHox);
               _vBox.addChild(_fristTxt);
               creatFrist(_loc7_);
               _vBox.addChild(_fristHox);
               _loc4_ = TempleteManager.instance.getSkillTemplateInfoById(_loc7_.tempInfo.Skill);
               if(_loc4_)
               {
                  _skillTxt.text = LanguageMgr.GetTranslation("RemotePetTurnTip.skillTxt",_loc4_.TemplateName);
                  _skillTxt.height = _skillTxt.numLines >= 2 ? 44 : 22;
                  _vBox.addChild(_skillTxt);
               }
               _vBox.addChild(_line02);
               if(_loc7_.tempInfo.SweepIndex > 1)
               {
                  _mopupValue.text = LanguageMgr.GetTranslation("RemotePetTurnTip.mopupValue",_loc7_.tempInfo.SweepIndex);
                  _mopupValue.height = _mopupValue.numLines >= 2 ? 44 : 22;
                  _vBox.addChild(_mopupValue);
               }
            }
            else
            {
               _vBox.addChild(_fristTxt);
               creatFrist(_loc7_);
               _vBox.addChild(_fristHox);
            }
         }
         _bg.height = _vBox.y + _vBox.height + 10;
         _purpleBg.height = _bg.height - 10;
      }
      
      private function creatFrist(param1:RemotePetTurnItemInfo) : void
      {
         var _loc2_:Array = null;
         var _loc5_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         if(param1.tempInfo.FirstDropItems)
         {
            for each(var _loc3_:String in param1.tempInfo.FirstDropItems.split(","))
            {
               if(_loc3_)
               {
                  _loc2_ = _loc3_.split("|");
                  _loc5_ = ComponentFactory.Instance.creatCustomObject("RemotePetTurnTip.dropItem");
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc2_[0];
                  _loc4_.count = _loc2_[1];
                  _loc5_.data = _loc4_;
                  _fristHox.addChild(_loc5_);
               }
            }
         }
      }
      
      private function clean() : void
      {
         _index.text = "";
         _vBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:BaseItemView in _dropHox)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(_dropHox)
         {
            _dropHox.removeAllChild();
         }
         for each(var _loc2_:BaseItemView in _fristHox)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         if(_fristHox)
         {
            _fristHox.removeAllChild();
         }
         ObjectUtils.disposeObject(_purpleBg);
         _purpleBg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_index);
         _index = null;
         ObjectUtils.disposeObject(_typeIcon);
         _typeIcon = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_dropTxt);
         _dropTxt = null;
         ObjectUtils.disposeObject(_fristTxt);
         _fristTxt = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_mopupValue);
         _mopupValue = null;
         ObjectUtils.disposeObject(_dropHox);
         _dropHox = null;
         ObjectUtils.disposeObject(_fristHox);
         _fristHox = null;
         ObjectUtils.disposeObject(_line01);
         _line01 = null;
         ObjectUtils.disposeObject(_line02);
         _line02 = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.removeChildAllChildren(this);
         super.dispose();
      }
   }
}

