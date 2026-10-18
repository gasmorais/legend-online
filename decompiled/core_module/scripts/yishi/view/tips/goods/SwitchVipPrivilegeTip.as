package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   
   public class SwitchVipPrivilegeTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      public function SwitchVipPrivilegeTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:FilterFrameText = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         super.init();
         _bg.width = 100;
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.SkillTotalBox");
         _totalBox.x = -5;
         _totalBox.y = 11;
         _totalBox.spacing = 4;
         addChild(_totalBox);
         var _loc5_:Array = getVipList();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(_loc5_[_loc4_].para1 < 100)
            {
               _loc3_ = 100 - _loc5_[_loc4_].para1 + "";
            }
            else
            {
               _loc3_ = _loc5_[_loc4_].para1 + "";
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("tips.PetAttributeView.desctxt");
            _loc2_.text = LanguageMgr.GetTranslation("tips.SwitchVipPrivilegeTip.desctxt",_loc5_[_loc4_].grade,_loc3_);
            _totalBox.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:FilterFrameText = null;
         var _loc3_:int = 0;
         var _loc2_:int = VIPManager.Instance.model.vipInfo.VipGrade;
         var _loc4_:Array = getVipList();
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc1_ = _totalBox.getChildAt(_loc3_) as FilterFrameText;
            _loc1_.setFrame(1);
            if(_loc4_[_loc3_].grade == _loc2_)
            {
               _loc1_.setFrame(2);
            }
            _loc3_++;
         }
         _bg.height = _totalBox.height + 15;
      }
      
      private function getVipList() : Array
      {
         return TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(202);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

