package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildNsEmblemResiUpTips extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _line:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var listArr:Array = [129,130,131,135];
      
      private var attNameList0:Array = ["Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
      
      private var attNameList1:Array = ["FireResi","WaterResi","WindResi","ElectResi","LightResi","DarkResi"];
      
      private var attNameList2:Array = ["ReduceResi"];
      
      private var attNameList3:Array = ["Live","Attack","Defence","MagicAttack","MagicDefence"];
      
      public function ChildNsEmblemResiUpTips()
      {
         super();
         _bg.width = 200;
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.childNsEmblemResiUpNameText");
         _level = ComponentFactory.Instance.creatComponentByStylename("tips.childNsEmblemResiUpLevelText");
         _line = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         _line.width = _bg.width - 16;
         _line.x = 8;
         _line.y = 30;
         _vBox = new VBox();
         _vBox.y = 35;
         _vBox.x = 15;
         _vBox.spacing = 1;
         addChild(_name);
         addChild(_level);
         addChild(_line);
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc10_:int = 0;
         var _loc2_:SkillPropertyTempInfo = null;
         var _loc8_:Array = null;
         var _loc3_:int = 0;
         var _loc9_:UpgradeTemplateInfo = null;
         var _loc4_:String = null;
         var _loc11_:String = null;
         var _loc5_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(tipData)
         {
            ObjectUtils.removeChildAllChildren(_vBox);
            _loc10_ = int(tipData) - 1;
            _loc8_ = this["attNameList" + _loc10_];
            _loc3_ = getCurGrade(_loc10_);
            _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_,listArr[_loc10_]);
            if(!_loc9_)
            {
               return;
            }
            _loc4_ = LanguageMgr.GetTranslation("ChildNsEmblemResiUpFrame.title.text" + _loc10_);
            _loc11_ = "" + _loc3_;
            if(_loc10_ == 0)
            {
               _loc2_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc9_.ActiveObject);
            }
            _loc5_ = int(_loc8_.length);
            _loc6_ = "";
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.childNsEmblemResiUpText");
               if(_loc10_ == 0)
               {
                  _loc6_ = "" + _loc2_[_loc8_[_loc7_]];
               }
               else if(_loc10_ == 3)
               {
                  _loc6_ = "" + _loc9_.TemplateName.split(",")[_loc7_];
               }
               else
               {
                  _loc6_ = "" + _loc9_.ActiveObject;
               }
               _loc1_.text = LanguageMgr.GetTranslation("ChildNsEmblemResiUpFrame.title.text" + _loc10_ + "" + _loc7_,_loc6_);
               _vBox.addChild(_loc1_);
               _loc7_ += 1;
            }
            _name.text = _loc4_;
            _level.text = LanguageMgr.GetTranslation("public.level2",_loc11_);
            _level.x = _name.x + _name.textWidth + 8;
            _vBox.refreshChildPos();
            _bg.width = _level.x + _level.textWidth + 20;
            _line.width = _bg.width - 16;
            _bg.height = 38 + _vBox.height;
         }
      }
      
      private function getCurGrade(param1:int) : int
      {
         if(param1 == 0)
         {
            return nsModel.selectedNsChild.emblemLv;
         }
         if(param1 == 1)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.resiGrade;
         }
         if(param1 == 2)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.reduceResiGrade;
         }
         if(param1 == 3)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.awakeGrade;
         }
         return 0;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         listArr = [];
         attNameList0 = [];
         attNameList1 = [];
         attNameList2 = [];
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

