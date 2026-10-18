package yishi.view.tips.goods
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusTreasureGrowupInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class TreasureTipsContent extends Sprite implements Disposeable
   {
      
      private var _equipIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _addImg:Bitmap;
      
      private var _strengImg:BitmapData;
      
      private var _strengNumSprite:Sprite;
      
      private var _refreshTitle:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      private var _intensifyText:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _contain2:Sprite;
      
      private var _grade:FilterFrameText;
      
      private var _subBox2:VBox;
      
      private var _skill:FilterFrameText;
      
      private var _subBox3:VBox;
      
      private var _describe:FilterFrameText;
      
      private var _baseLine:Bitmap;
      
      private var _attributeLine:Bitmap;
      
      private var _refreshLine:Bitmap;
      
      public function TreasureTipsContent()
      {
         super();
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _addImg = ComponentFactory.Instance.creatBitmap("asset.tips.addImg");
         _strengNumSprite = new Sprite();
         _strengNumSprite.y = 11;
         _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
         _refreshTitle = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _intensifyText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodIntensifyText_2");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox3 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox3");
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText");
         _skill = ComponentFactory.Instance.creatComponentByStylename("tips.GoodSkillText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         _subBox1.spacing = 2;
         _subBox2.spacing = 2;
         _subBox3.spacing = 2;
         _contain2 = new Sprite();
         _subBox1.addChild(_contain2);
         _baseLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _attributeLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _refreshLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         addChild(_equipIcon);
         addChild(_profileImg);
         _profileImg.setFrame(1);
         addChild(_addImg);
         addChild(_strengNumSprite);
         addChild(_title);
         addChild(_totalBox);
         _totalBox.y = 17;
         _describe.width = 253;
         _intensifyText.x = 45;
      }
      
      protected function initBase(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         _title.setFrame(param2.Profile);
         _title.text = param2.TemplateName;
         _equipIcon.icon = IconFactory.getGoodsIconByTID(param2.TemplateId);
         _equipIcon.visible = true;
         _totalBox.y = 58;
         _profileImg.setFrame(param2.Profile);
         if(param1.strengthenGrade > 0)
         {
            _addImg.visible = true;
            _strengNumSprite.visible = true;
            setStrengNum(param1.strengthenGrade);
            _title.width = 145;
         }
         else
         {
            _addImg.visible = false;
            _strengNumSprite.visible = false;
            _title.width = 183;
         }
         _addImg.x = _title.x + (145 - _title.textWidth) / 2 + _title.textWidth + 2;
         _strengNumSprite.x = _addImg.x + 15;
         _intensifyText.text = param1.templateInfo.StrengthenMax == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.intensify",param1.templateInfo.StrengthenMax);
         if(!GoodsCheck.isGradeFix(thane,param2,false))
         {
            _grade.textColor = 16711680;
         }
         if(param1.isBinds)
         {
            _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
            _bindText.setFrame(1);
         }
         else
         {
            _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
            _bindText.setFrame(2);
         }
         _describe.text = param2.Description;
         _describe.height = _describe.textHeight + _describe.numLines * 4;
      }
      
      private function initAttribute(param1:GoodsInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TreasureAttributeItem = null;
         _subBox2.removeAllChild();
         var _loc4_:TheseusTreasureGrowupInfo = getGrowupInfo(param1.templateId,param1.strengthenGrade);
         if(_loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.attNames.length)
            {
               _loc2_ = new TreasureAttributeItem();
               _loc2_.updateText(_loc4_.attNames[_loc3_],_loc4_.attValues[_loc3_].toString());
               _subBox2.addChild(_loc2_);
               _loc3_++;
            }
         }
      }
      
      private function getGrowupInfo(param1:int, param2:int) : TheseusTreasureGrowupInfo
      {
         return TempleteManager.instance.theseusTreasureGrowupCate.getTempInfoByIdLevel(param1,param2);
      }
      
      private function setStrengNum(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,15,19,"0123456789");
      }
      
      private function initSkill(param1:GoodsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:SkillTempInfo = null;
         var _loc3_:TreasureSkillItem = null;
         _subBox3.removeAllChild();
         _loc4_ = 1;
         while(_loc4_ < 6)
         {
            _loc5_ = int(param1["randomSkill" + _loc4_]);
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc5_);
            if(_loc2_)
            {
               if(_loc4_ == 1)
               {
                  _refreshTitle.text = LanguageMgr.GetTranslation("TreasurePageView.skill.text");
                  _refreshTitle.autoSize = "left";
                  _subBox3.addChild(_refreshTitle);
               }
               _loc3_ = new TreasureSkillItem();
               _loc3_.data = _loc2_;
               _subBox3.addChild(_loc3_);
            }
            _loc4_++;
         }
         _subBox3.addChild(_refreshLine);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      protected function initData(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         initBase(param1,param2);
         initAttribute(param1);
         initSkill(param1);
      }
      
      public function clean() : void
      {
         _subBox2.removeAllChild();
         _subBox3.removeAllChild();
         _totalBox.removeAllChild();
      }
      
      public function set spacing(param1:Number) : void
      {
         _totalBox.beginChanges();
         _totalBox.spacing = param1;
         _totalBox.commitChanges();
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         clean();
         initData(param1,TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId));
         _totalBox.beginChanges();
         if(param1.templateInfo.StrengthenMax > 0)
         {
            _contain2.addChild(_intensifyText);
         }
         if(_subBox1.numChildren > 0)
         {
            _totalBox.addChild(_subBox1);
            _totalBox.addChild(_baseLine);
         }
         if(_subBox2.numChildren > 0)
         {
            _totalBox.addChild(_subBox2);
            _totalBox.addChild(_attributeLine);
         }
         if(_subBox3.numChildren > 0)
         {
            _totalBox.addChild(_subBox3);
            _totalBox.addChild(_refreshLine);
         }
         if(!StringHelper.isNullOrEmpty(_describe.text))
         {
            _totalBox.addChild(_describe);
         }
         _totalBox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_contain2);
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_bindText)
         {
            _bindText.dispose();
         }
         _bindText = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_subBox1)
         {
            _subBox1.dispose();
         }
         _subBox1 = null;
         if(_grade)
         {
            _grade.dispose();
         }
         _grade = null;
         if(_subBox2)
         {
            _subBox2.dispose();
         }
         _subBox2 = null;
         if(_skill)
         {
            _skill.dispose();
         }
         _skill = null;
         if(_subBox3)
         {
            _subBox3.dispose();
         }
         _subBox3 = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_addImg)
         {
            ObjectUtils.disposeObject(_addImg);
         }
         _addImg = null;
         if(_strengNumSprite)
         {
            ObjectUtils.disposeObject(_strengNumSprite);
         }
         _strengNumSprite = null;
         if(_strengImg)
         {
            ObjectUtils.disposeObject(_strengImg);
         }
         _strengImg = null;
         if(_refreshTitle)
         {
            ObjectUtils.disposeObject(_refreshTitle);
         }
         _refreshTitle = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

