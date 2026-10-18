package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.childpatrol.ChildPatrolCheckCondictionHelper;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.goods.FashionAttItem;
   
   public class ChildPatrolItemTip extends BaseTip
   {
      
      private var headIcon:BaseIconView;
      
      private var parentText:FilterFrameText;
      
      private var gradeText:FilterFrameText;
      
      private var nameText:FilterFrameText;
      
      private var splitLine:Bitmap;
      
      private var attVbox:VBox;
      
      public function ChildPatrolItemTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         headIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         parentText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         gradeText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         nameText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodVocationText");
         splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         attVbox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolItemTip.Attvbox");
         addChild(headIcon);
         addChild(parentText);
         addChild(gradeText);
         addChild(nameText);
         addChild(splitLine);
         addChild(attVbox);
         headIcon.x = 15;
         headIcon.y = -9;
         parentText.x = 81;
         parentText.y = 20;
         parentText.width = 150;
         gradeText.x = 6;
         gradeText.y = 60;
         nameText.x = 7;
         nameText.y = 60;
         nameText.width = 250;
         splitLine.y = 85;
         splitLine.scaleX = 0.95;
         _bg.height = 300;
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:Array = null;
         var _loc4_:ChildTempInfo = null;
         var _loc2_:int = 0;
         var _loc1_:FashionAttItem = null;
         var _loc3_:String = null;
         cleanData();
         if(tipData is ChildData)
         {
            _loc5_ = getAttData();
            headIcon.visible = true;
            splitLine.visible = true;
            headIcon.icon = IconFactory.getChildrenHeadSmallIcon(_data.job,_data.growthGrade);
            parentText.text = _data.name;
            gradeText.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
            _loc4_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            nameText.text = _loc4_.JobName;
            _loc2_ = 0;
            while(_loc2_ < 11)
            {
               _loc1_ = new FashionAttItem();
               _loc3_ = _loc5_[_loc2_];
               if(_loc2_ == 2)
               {
                  _loc3_ = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _loc3_);
               }
               _loc1_.setData(LanguageMgr.GetTranslation("ChildPatrolItemTip.FashionAttItem.text" + _loc2_,_loc3_));
               attVbox.addChild(_loc1_);
               _loc2_++;
            }
            _bg.height = attVbox.y + attVbox.height + 5;
         }
      }
      
      private function cleanData() : void
      {
         attVbox.removeAllChild();
         headIcon.visible = false;
         splitLine.visible = false;
         parentText.text = "";
         gradeText.text = "";
         nameText.text = "";
      }
      
      private function getAttData() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         if(tipData is ChildData)
         {
            _loc2_[0] = _data.growthGrade;
            _loc2_[1] = _data.emblemLv;
            _loc2_[2] = ChildPatrolCheckCondictionHelper.getChildEquipQualityData(_data as ChildData);
            _loc2_[3] = ChildPatrolCheckCondictionHelper.getChildSkillGradesData(_data as ChildData);
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               _loc2_[_loc1_ + 4] = (_data as ChildData).ResiValueArr[_loc1_];
               _loc1_++;
            }
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(headIcon)
         {
            ObjectUtils.disposeObject(headIcon);
         }
         headIcon = null;
         if(parentText)
         {
            ObjectUtils.disposeObject(parentText);
         }
         parentText = null;
         if(gradeText)
         {
            ObjectUtils.disposeObject(gradeText);
         }
         gradeText = null;
         if(nameText)
         {
            ObjectUtils.disposeObject(nameText);
         }
         nameText = null;
         if(splitLine)
         {
            ObjectUtils.disposeObject(splitLine);
         }
         splitLine = null;
         if(attVbox)
         {
            ObjectUtils.disposeObject(attVbox);
         }
         attVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

