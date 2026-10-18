package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.gamehall.GameHallBlessInfo;
   
   public class EastBlessTips extends BaseTip
   {
      
      private var _title1:FilterFrameText;
      
      private var _vbox:VBox;
      
      public function EastBlessTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 190;
         _title1 = ComponentFactory.Instance.creatComponentByStylename("tips.EastBlessTips.Title");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("tips.EastBlessTips.vbox");
         addChild(_title1);
         addChild(_vbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc7_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:Sprite = null;
         var _loc6_:FilterFrameText = null;
         var _loc1_:FilterFrameText = null;
         var _loc3_:GameHallBlessInfo = null;
         var _loc5_:int = 0;
         if(tipData)
         {
            ObjectUtils.disposeAllChildren(_vbox);
            _loc7_ = tipData as Array;
            _loc2_ = int(_loc7_.length);
            _title1.text = LanguageMgr.GetTranslation("yishi.view.tips.EastBlessTips.titileTxt");
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc3_ = _loc7_[_loc5_] as GameHallBlessInfo;
               if(_loc3_ && _loc3_.skillTempInfo)
               {
                  _loc4_ = new Sprite();
                  _loc6_ = ComponentFactory.Instance.creatComponentByStylename("tips.EastBlessTips.blessName");
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.EastBlessTips.blessLevel");
                  _loc6_.text = _loc3_.skillTempInfo.TemplateName;
                  if(_loc3_.level >= _loc3_.skillTempInfo.Grades)
                  {
                     _loc1_.setFrame(2);
                  }
                  else
                  {
                     _loc1_.setFrame(1);
                  }
                  _loc1_.text = _loc3_.level + "/" + _loc3_.skillTempInfo.Grades;
                  _loc1_.x = _loc6_.x + _loc6_.textWidth + 10;
                  _loc4_.addChild(_loc6_);
                  _loc4_.addChild(_loc1_);
                  _vbox.addChild(_loc4_);
               }
               _loc5_++;
            }
         }
         _bg.height = _vbox.height + 35;
      }
      
      override public function dispose() : void
      {
         if(_title1)
         {
            ObjectUtils.disposeObject(_title1);
         }
         _title1 = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

