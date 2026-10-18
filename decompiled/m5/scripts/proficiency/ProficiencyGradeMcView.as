package proficiency
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import mvc.module.proficiency.ProficiencyModel;
   import yishi.manager.ProficiencyManager;
   
   public class ProficiencyGradeMcView extends Component
   {
      
      private var _ballMcCon:Component;
      
      private var ballPosAry:Array = [[173,0],[315,85],[315,230],[173,320],[35,230],[35,85]];
      
      private var preBallCount:int;
      
      public function ProficiencyGradeMcView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _ballMcCon = ComponentFactory.Instance.creatComponentByStylename("ProficiencyGradeMcView.ballMcCon");
         addChild(_ballMcCon);
      }
      
      public function initBallView() : void
      {
         var _loc1_:MovieClip = null;
         var _loc3_:int = 0;
         ObjectUtils.disposeAllChildren(_ballMcCon);
         var _loc2_:int = model.proficiencyGrade % 7;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ProficiencyGradeMcView.ballMc");
            _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
            _loc1_.x = ballPosAry[_loc3_][0];
            _loc1_.y = ballPosAry[_loc3_][1];
            _ballMcCon.addChild(_loc1_);
            if(_loc3_ < _loc2_)
            {
               _loc1_.visible = true;
               _loc1_.gotoAndPlay(18);
            }
            else
            {
               _loc1_.visible = false;
               _loc1_.gotoAndStop(1);
            }
            _loc3_++;
         }
         preBallCount = _loc2_;
      }
      
      public function refreshView() : void
      {
         var _loc1_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc2_:int = model.proficiencyGrade % 7;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = _ballMcCon.getChildAt(_loc3_) as MovieClip;
            if(preBallCount > 0 && _loc2_ == 0)
            {
               _loc1_.visible = false;
               _loc1_.gotoAndStop(1);
            }
            else if(_loc3_ < _loc2_ - 1)
            {
               _loc1_.visible = true;
               _loc1_.gotoAndPlay(18);
            }
            else if(_loc3_ == _loc2_ - 1)
            {
               _loc1_.visible = true;
               _loc1_.gotoAndPlay(1);
            }
            else
            {
               _loc1_.visible = false;
               _loc1_.gotoAndStop(1);
            }
            _loc3_++;
         }
         preBallCount = _loc2_;
      }
      
      private function get model() : ProficiencyModel
      {
         return ProficiencyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         var _loc1_:MovieClip = null;
         if(_ballMcCon)
         {
            while(_ballMcCon.numChildren > 0)
            {
               _loc1_ = _ballMcCon.getChildAt(0) as MovieClip;
               ObjectUtils.disposeViolentMc(_loc1_);
            }
            ObjectUtils.disposeObject(_ballMcCon);
            _ballMcCon = null;
         }
         super.dispose();
      }
   }
}

