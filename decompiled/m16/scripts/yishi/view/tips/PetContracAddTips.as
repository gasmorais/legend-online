package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   
   public class PetContracAddTips extends BaseTip
   {
      
      private var titleText:FilterFrameText;
      
      private var addTextVbox:VBox;
      
      public function PetContracAddTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = ComponentFactory.Instance.creatComponentByStylename("PetContracAddTips.titleText");
         addTextVbox = ComponentFactory.Instance.creatComponentByStylename("PetContracAddTips.addTextVbox");
         addChild(titleText);
         addChild(addTextVbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:FilterFrameText = null;
         var _loc6_:int = 0;
         var _loc3_:Dictionary = null;
         var _loc7_:String = null;
         var _loc9_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:PetHallowsTemplateInfo = null;
         var _loc12_:SkillTempInfo = null;
         var _loc13_:String = null;
         var _loc2_:String = null;
         var _loc10_:String = null;
         var _loc8_:Array = null;
         addTextVbox.removeAllChild();
         if(tipData)
         {
            _loc6_ = int(tipData.type);
            _loc3_ = tipData.dic as Dictionary;
            _loc7_ = LanguageMgr.GetTranslation("PetContracAddTips.titleText.text" + _loc6_);
            _loc9_ = getDicKeys(_loc3_);
            _loc4_ = 0;
            if(_loc6_ == 1 || _loc6_ == 2)
            {
               while(_loc4_ < _loc9_.length)
               {
                  _loc5_ = int(_loc9_[_loc4_]);
                  if(_loc5_ == 0 && (thane.job == 3 || thane.job == 6))
                  {
                     _loc5_ = 1;
                  }
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("PetContracAddTips.addPropText");
                  addTextVbox.addChild(_loc1_);
                  _loc1_.htmlText = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + _loc5_) + "+" + _loc3_[_loc9_[_loc4_]];
                  _loc4_++;
               }
               if(addTextVbox.numChildren <= 0)
               {
                  _loc7_ += LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
               }
            }
            else if(_loc6_ == 3)
            {
               while(_loc4_ < _loc9_.length)
               {
                  _loc11_ = _loc3_[_loc9_[_loc4_]];
                  _loc12_ = TempleteManager.instance.getSkillById(_loc11_.SkillTempId);
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("PetContracAddTips.addPropText");
                  addTextVbox.addChild(_loc1_);
                  _loc13_ = _loc11_.TemplateName + " " + LanguageMgr.GetTranslation("public.level4_space2",_loc11_.Grades);
                  _loc2_ = _loc12_.Grades >= 10 ? "&nbsp;&nbsp; " : "&nbsp;&nbsp;&nbsp;";
                  _loc1_.htmlText = LanguageMgr.GetTranslation("public.level2",_loc12_.Grades) + _loc2_ + LanguageMgr.GetTranslation("PetContracAddTips.addvalueText.text2",_loc13_);
                  _loc4_++;
               }
            }
            else if(_loc6_ == 4)
            {
               while(_loc4_ < _loc9_.length)
               {
                  _loc5_ = int(_loc9_[_loc4_]);
                  _loc8_ = _loc3_[_loc5_].split("_");
                  if(int(_loc8_[0]) > 0)
                  {
                     _loc1_ = ComponentFactory.Instance.creatComponentByStylename("PetContracAddTips.addPropText");
                     addTextVbox.addChild(_loc1_);
                     _loc10_ = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + _loc5_) + "+" + _loc8_[0];
                     if(int(_loc8_[1]) > 0)
                     {
                        _loc10_ += "&nbsp;&nbsp;" + LanguageMgr.GetTranslation("PetContracAddTips.addvalueText.text",_loc8_[1]);
                     }
                     _loc1_.htmlText = _loc10_;
                  }
                  _loc4_++;
               }
               if(addTextVbox.numChildren <= 0)
               {
                  _loc7_ += LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
               }
            }
            titleText.text = _loc7_;
            _bg.height = addTextVbox.height + 55;
            _bg.width = 300;
         }
      }
      
      private function getDicKeys(param1:Dictionary) : Array
      {
         var _loc3_:Array = [];
         for(var _loc2_:String in param1)
         {
            _loc3_.push(int(_loc2_));
         }
         _loc3_.sort(16);
         return _loc3_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         if(titleText)
         {
            ObjectUtils.disposeObject(titleText);
         }
         titleText = null;
         if(addTextVbox)
         {
            ObjectUtils.disposeObject(addTextVbox);
         }
         addTextVbox = null;
         super.dispose();
      }
   }
}

