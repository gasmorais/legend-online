package yishi.view.tips.goods
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class ChatEquipTips extends EquipTip
   {
      
      private var _closeBtn:BaseButton;
      
      public function ChatEquipTips()
      {
         super();
         mouseEnabled = mouseChildren = true;
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 382;
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("tips.ChatEquipCloseBtn");
         _closeBtn.x = 360;
         _closeBtn.y = 30;
         addChild(_closeBtn);
         initEvent();
         _totalBox.x = 10;
         _totalBox.y = 60;
      }
      
      override protected function updateTransform() : void
      {
         var _loc8_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc6_:SkillTempInfo = null;
         var _loc7_:Array = null;
         var _loc4_:String = null;
         if(tipData)
         {
            _loc8_ = tipData as GoodsInfo;
            _loc3_ = _loc8_.templateInfo;
            _equipTipsContent.data = _loc8_;
            _totalBox.addChild(_equipTipsContent);
            _loc5_ = _loc8_.getEquipBaseScore();
            _loc1_ = _loc8_.getEquipAdditionScore();
            if(_loc1_ > 0)
            {
               _loc2_ = _loc5_ + " (+" + _loc1_ + ")";
            }
            else
            {
               _loc2_ = _loc5_ + "";
            }
            _gradeCount.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.ChatEquipTips.gradeCount",_loc2_);
            if(FrameControllerManager.instance.fashionCodeController.model.isFashion(_loc8_))
            {
               if(_gradeCount && _gradeCount.parent)
               {
                  _gradeCount.parent.removeChild(_gradeCount);
               }
               _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc8_.appraisal_skill);
               if(VersionSwitch.FASHION_APPRAISAL)
               {
                  if(_hbox && _loc6_)
                  {
                     _hbox.removeAllChild();
                     _totalBox.addChild(_hbox);
                     addFashionStar(_loc6_.Grades);
                  }
               }
               _loc7_ = [" ","S","A","B","C","D"];
               if(_loc3_.TransformId > 0)
               {
                  _loc4_ = StringHelper.format("<font color=\'{0}\'>{1}</font>",GoodsSonType.getColorByProfile(6 - _loc3_.TransformId),_loc7_[_loc3_.TransformId] + LanguageMgr.GetTranslation("public.level"));
               }
               else
               {
                  _loc4_ = "";
               }
               if(_loc3_.Property4 == 0)
               {
                  _fashionProfileTxt.setFrame(3);
                  _fashionProfileTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.specialFashion") + " " + _loc4_;
                  _fashionProfileTxt.x = 0;
                  _totalBox.addChild(_fashionProfileTxt);
               }
               else if(_loc3_.Property4 == 2)
               {
                  _fashionProfileTxt.setFrame(2);
                  _fashionProfileTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.activeFashion") + " " + _loc4_;
                  _fashionProfileTxt.x = 0;
                  _totalBox.addChild(_fashionProfileTxt);
               }
               else
               {
                  _fashionProfileTxt.setFrame(1);
                  _fashionProfileTxt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.normalFashion") + " " + _loc4_;
                  _fashionProfileTxt.x = 0;
                  _totalBox.addChild(_fashionProfileTxt);
               }
            }
            _price.text = _loc3_.SellGold == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",GoodsCheck.getSellGold(_loc8_));
            _totalBox.beginChanges();
            if(_loc8_.id != 0)
            {
               _totalBox.addChild(_price);
            }
            _totalBox.commitChanges();
            _blackKingBg.y = _redBg.y = _yellowBg.y = _purpleBg.y = _blueBg.y = _greenBg.y = _whiteBg.y = _bg.y = 38;
            _bg.height = int(_totalBox.y + _totalBox.height - 23);
            _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width = 380;
            _blackKingBg.height = _redBg.height = _yellowBg.height = _purpleBg.height = _blueBg.height = _greenBg.height = _whiteBg.height = _bg.height = _bg.height;
            showProfileBg(_loc8_.templateInfo.Profile);
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         _redBg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         _blackKingBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
               break;
            case 6:
               _blackKingBg.visible = true;
         }
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__closeHandler);
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         removeEvent();
         dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

