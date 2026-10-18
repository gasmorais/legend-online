package child.emblem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.EnterChildPet;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildEmblemUpGradeFrame extends ChildEmblemUpView
   {
      
      private var _back:MutipleImage;
      
      private var _maxLevelBmp:Bitmap;
      
      private var _vBox1:VBox;
      
      private var _vBox2:VBox;
      
      private var _vBox3:VBox;
      
      private var _vBox4:VBox;
      
      private var _vBox5:VBox;
      
      private var _vBox6:VBox;
      
      private var _attNameList:Array;
      
      private var _txtList:Vector.<FilterFrameText>;
      
      private var _data:ChildData;
      
      public function ChildEmblemUpGradeFrame()
      {
         super();
         initData();
      }
      
      private function initData() : void
      {
         _data = model.selectedChild;
         _attNameList = ["Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.back");
         _maxLevelBmp = ComponentFactory.Instance.creatBitmap("asset.ChildEmblemUpGradeFrame.maxLevel");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox1");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox2");
         _vBox3 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox3");
         _vBox4 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox4");
         _vBox5 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox5");
         _vBox6 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox6");
         _txtList = new Vector.<FilterFrameText>();
         addToContent(_back);
         addToContent(_maxLevelBmp);
         addToContent(_vBox1);
         addToContent(_vBox2);
         addToContent(_vBox3);
         addToContent(_vBox4);
         addToContent(_vBox5);
         addToContent(_vBox6);
         _bg.width = 460;
         _bg.height = 440;
         _upBtn.x = 168;
         _upBtn.y = 392;
         _opSp.x = 90;
         addImageAndTxt();
      }
      
      private function addImageAndTxt() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeViewII.imageTxt" + (_loc3_ + 4));
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _vBox1.addChild(_loc2_);
            _vBox2.addChild(_loc1_);
            _loc1_.setFrame(1);
            _txtList.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeViewII.imageTxt" + (_loc3_ + 4));
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _vBox3.addChild(_loc2_);
            _vBox4.addChild(_loc1_);
            _loc1_.setFrame(2);
            _txtList.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.ChildEmblemUpGradeFrame.upImage");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _vBox5.addChild(_loc2_);
            _vBox6.addChild(_loc1_);
            _loc1_.setFrame(2);
            _txtList.push(_loc1_);
            _loc3_++;
         }
      }
      
      override protected function unitView() : void
      {
         super.unitView();
         cleanList();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_maxLevelBmp);
         _maxLevelBmp = null;
         ObjectUtils.disposeObject(_vBox1);
         _vBox1 = null;
         ObjectUtils.disposeObject(_vBox2);
         _vBox2 = null;
         ObjectUtils.disposeObject(_vBox3);
         _vBox3 = null;
         ObjectUtils.disposeObject(_vBox4);
         _vBox4 = null;
         ObjectUtils.disposeObject(_vBox5);
         _vBox5 = null;
         ObjectUtils.disposeObject(_vBox6);
         _vBox6 = null;
         LogicUtils.disposeDisplayCollection(_txtList);
         _txtList = null;
         _data = null;
         _attNameList = null;
      }
      
      private function cleanList() : void
      {
         if(_txtList)
         {
            while(_txtList.length > 0)
            {
               _txtList.pop().dispose();
            }
            _txtList = null;
         }
      }
      
      override protected function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(model.selectedChild == null)
         {
            dispose();
            return;
         }
         super.refreshView();
         updateAttribute(false);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.emblemLv + 1,47);
         if(_loc2_)
         {
            updateAttribute(true);
            _loc1_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _attNameList.length)
            {
               _loc1_ = parseInt(_txtList[_loc3_ + _attNameList.length].text) - parseInt(_txtList[_loc3_].text);
               _txtList[_loc3_ + _attNameList.length * 2].text = _loc1_ + "";
               _loc3_++;
            }
            _maxLevelBmp.visible = false;
         }
         else
         {
            _vBox3.visible = _vBox4.visible = _vBox5.visible = _vBox6.visible = false;
            _maxLevelBmp.visible = true;
         }
      }
      
      private function updateAttribute(param1:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc9_:SkillPropertyTempInfo = null;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc2_:Vector.<SkillPropertyTempInfo> = new Vector.<SkillPropertyTempInfo>();
         var _loc10_:Vector.<SkillPropertyTempInfo> = new Vector.<SkillPropertyTempInfo>();
         if(param1)
         {
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_data.emblemLv + 1,47);
         }
         else
         {
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_data.emblemLv,47);
         }
         if(_loc4_)
         {
            _loc9_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc4_.ActiveObject);
         }
         if(_loc9_)
         {
            if(_loc9_.AddType == 0)
            {
               _loc10_.push(_loc9_);
            }
            else
            {
               _loc2_.push(_loc9_);
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _attNameList.length)
         {
            _loc5_ = _loc8_ = _data.hasOwnProperty(_attNameList[_loc6_]) ? int(_data[_attNameList[_loc6_]]) * 2 : 0;
            if(_attNameList[_loc6_].indexOf("Emblem") < 0)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  if(_loc2_[_loc7_].AddType == 1)
                  {
                     _loc9_ = _loc2_[_loc7_];
                     _loc5_ += _loc9_[_attNameList[_loc6_]];
                     if(_attNameList[_loc6_] == "Defence")
                     {
                        _loc5_ += _loc9_["Agility"] * 4;
                        _loc5_ = _loc5_ + _loc9_["Power"];
                     }
                     if(_attNameList[_loc6_] == "MagicDefence")
                     {
                        _loc5_ += _loc9_["Agility"] * 4;
                        _loc5_ = _loc5_ + _loc9_["Intellect"];
                     }
                     if(_attNameList[_loc6_] == "Attack")
                     {
                        _loc5_ += _loc9_["Power"] * 4;
                     }
                     if(_attNameList[_loc6_] == "MagicAttack")
                     {
                        _loc5_ += _loc9_["Intellect"] * 4;
                     }
                     if(_attNameList[_loc6_] == "Live")
                     {
                        _loc5_ += _loc9_["Physique"] * 20;
                     }
                  }
                  else if(_loc2_[_loc7_].AddType == 2)
                  {
                  }
                  _loc7_++;
               }
            }
            for each(_loc9_ in _loc10_)
            {
               if(_loc9_.AddType == 0 && Boolean(_loc9_.hasOwnProperty(_attNameList[_loc6_])))
               {
                  _loc5_ += int(_loc5_ * _loc9_[_attNameList[_loc6_]] / 100);
               }
            }
            if(param1)
            {
               _txtList[_loc6_ + _attNameList.length].text = _loc5_ + "";
            }
            else
            {
               _txtList[_loc6_].text = _loc5_ + "";
            }
            _loc6_++;
         }
      }
      
      private function get enterChildPet() : EnterChildPet
      {
         if(_data == null)
         {
            return null;
         }
         return _data.enterPet;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
   }
}

