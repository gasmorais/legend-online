package gamehall.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.gamehall.GameHallBlessInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GameHallSceneEastBlessBaseItemView extends Sprite
   {
      
      private var _baseIconView:BaseIconView;
      
      private var _levelTxt:FilterFrameText;
      
      private var _data:GameHallBlessInfo;
      
      private var _showCurrentLevel:Boolean = true;
      
      private var _needUserNewTips:Boolean = false;
      
      private var _tipsType:int;
      
      public function GameHallSceneEastBlessBaseItemView()
      {
         super();
         initView();
      }
      
      public function set tipsType(param1:int) : void
      {
         _tipsType = param1;
      }
      
      public function set showCurrentLevel(param1:Boolean) : void
      {
         _showCurrentLevel = param1;
      }
      
      public function set data(param1:GameHallBlessInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(!_data || !_data.skillTempInfo)
         {
            _baseIconView.icon = "";
            _levelTxt.text = "";
         }
         else
         {
            _loc2_ = IconFactory.getCommonIconPath(_data.skillTempInfo.Icons);
            if(_baseIconView.icon != _loc2_)
            {
               _baseIconView.icon = _loc2_;
            }
            if(_tipsType == 1)
            {
               _baseIconView.tipStyle = "yishi.view.tips.goods.SkillShowCurrentGradeTips";
               _baseIconView.tipData = _data;
            }
            else if(_tipsType == 2)
            {
               _baseIconView.tipStyle = "yishi.view.tips.goods.SkillNotShowGradeTips";
               _baseIconView.tipData = _data;
            }
            else
            {
               _baseIconView.tipStyle = "yishi.view.tips.goods.SkillTips";
               _baseIconView.tipData = _data.skillTempInfo;
            }
            if(_showCurrentLevel || _tipsType == 2)
            {
               _levelTxt.text = LanguageMgr.GetTranslation("public.level2",_data.level);
               if(_data.level == 0)
               {
                  this.visible = false;
               }
               else
               {
                  this.visible = true;
               }
            }
            else
            {
               _levelTxt.text = LanguageMgr.GetTranslation("public.level2",_data.skillTempInfo.Grades);
               if(_data.skillTempInfo.Grades == 0)
               {
                  this.visible = false;
               }
               else
               {
                  this.visible = true;
               }
            }
         }
      }
      
      private function initView() : void
      {
         _baseIconView = ComponentFactory.Instance.creatCustomObject("gamehall.room.GameHallSceneEastBlessBaseItemView.baseIconView");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessBaseItemView.levelTxt");
         addChild(_baseIconView);
         addChild(_levelTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_baseIconView);
         _baseIconView = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

