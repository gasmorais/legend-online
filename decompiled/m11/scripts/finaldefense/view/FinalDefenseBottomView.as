package finaldefense.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class FinalDefenseBottomView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var skillItemArr:Array;
      
      public function FinalDefenseBottomView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FinalDefenseSkillItem = null;
         skillItemArr = [];
         _bg = ComponentFactory.Instance.creatBitmap("asset.finaldefense.BottomViewBg");
         addChild(_bg);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("finaldefense.FinalDefenseSkillItem" + _loc1_,[_loc1_]);
            skillItemArr.push(_loc2_);
            addChild(_loc2_);
            _loc1_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < skillItemArr.length)
         {
            FinalDefenseSkillItem(skillItemArr[_loc1_]).updateView();
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _loc1_ = 0;
         while(_loc1_ < skillItemArr.length)
         {
            ObjectUtils.disposeObject(skillItemArr[_loc1_]);
            skillItemArr[_loc1_] = null;
            _loc1_++;
         }
         skillItemArr = null;
         super.dispose();
      }
   }
}

