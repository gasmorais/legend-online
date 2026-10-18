package battle.view.ui.top
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class BattleGoddessTopItem extends Component implements IManualSize
   {
      
      private var _goddessHeadMc:MovieClip;
      
      private var _goddessHead:BaseIconView;
      
      private var _data:HeroRoleInfo;
      
      private var mcBeliefMax:int = 100;
      
      private var _preBelief:int = 999;
      
      private var _preType:int = -1;
      
      public function BattleGoddessTopItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,95,112);
      }
      
      private function initView() : void
      {
         _goddessHeadMc = ComponentFactory.Instance.creatCustomObject("BattleGoddessTopItem.goddessHeadMc");
         _goddessHead = ComponentFactory.Instance.creatCustomObject("BattleGoddessTopItem.goddessHead");
         addChild(_goddessHeadMc);
         _goddessHeadMc["icon"].addChild(_goddessHead);
         _goddessHeadMc.gotoAndStop(1);
         _goddessHeadMc["progress"].gotoAndStop(1);
         _goddessHeadMc["fullMc1"].visible = false;
         _goddessHeadMc["fullMc2"].visible = false;
         _goddessHeadMc["fullMc1"].gotoAndStop(1);
         _goddessHeadMc["fullMc2"].gotoAndStop(1);
      }
      
      public function get data() : HeroRoleInfo
      {
         return _data;
      }
      
      public function set data(param1:HeroRoleInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var beliefValue:int;
         var frame:int;
         if(data && data.goddessRoleInfo)
         {
            if(_preBelief == data.goddessRoleInfo.belief)
            {
               return;
            }
            beliefValue = data.goddessRoleInfo.belief > mcBeliefMax ? mcBeliefMax : int(data.goddessRoleInfo.belief);
            frame = int(int(beliefValue / 2) > 0 ? int(beliefValue / 2) : 1);
            if(data.goddessRoleInfo.belief < _preBelief)
            {
               _goddessHeadMc["progress"].gotoAndStop(frame);
            }
            else
            {
               _goddessHeadMc["progress"].addFrameScript(frame - 1,function():void
               {
                  _goddessHeadMc["progress"].stop();
                  _goddessHeadMc["progress"].addFrameScript(frame - 1,null);
               });
               _goddessHeadMc.play();
               _goddessHeadMc["progress"].play();
            }
            _preBelief = data.goddessRoleInfo.belief;
            if(data.goddessRoleInfo.belief >= 100)
            {
               _goddessHeadMc["fullMc1"].visible = true;
               _goddessHeadMc["fullMc2"].visible = true;
               _goddessHeadMc["fullMc1"].gotoAndPlay(1);
               _goddessHeadMc["fullMc2"].gotoAndPlay(1);
            }
            else
            {
               _goddessHeadMc["fullMc1"].visible = false;
               _goddessHeadMc["fullMc2"].visible = false;
               _goddessHeadMc["fullMc1"].gotoAndStop(1);
               _goddessHeadMc["fullMc2"].gotoAndStop(1);
            }
            if(data.goddessRoleInfo && data.goddessRoleInfo.template.Type != _preType)
            {
               _goddessHead.icon = PathManager.getBattleGoddessHeadPath(data.goddessRoleInfo.template.Type);
               _preType = data.goddessRoleInfo.templateId;
            }
         }
         else
         {
            _goddessHead.icon = null;
            _goddessHeadMc.gotoAndStop(1);
            _goddessHeadMc["progress"].gotoAndStop(1);
            _goddessHeadMc["fullMc1"].visible = false;
            _goddessHeadMc["fullMc2"].visible = false;
            _goddessHeadMc["fullMc1"].gotoAndStop(1);
            _goddessHeadMc["fullMc2"].gotoAndStop(1);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_goddessHead);
         _goddessHead = null;
         ObjectUtils.disposeViolentMc(_goddessHeadMc);
         _goddessHeadMc = null;
         super.dispose();
      }
   }
}

