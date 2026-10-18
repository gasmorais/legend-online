package crisis.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.crisis.PlaneCrisisCountInfo;
   import mvc.module.crisis.PlaneCrisisEventType;
   import mvc.module.crisis.PlaneCrisisNodeInfo;
   import yishi.manager.PlaneCrisisManager;
   
   public class PlaneCrisisEventItem extends Sprite
   {
      
      private var _icon:Image;
      
      private var _countTxt:FilterFrameText;
      
      private var _data:PlaneCrisisCountInfo;
      
      public function PlaneCrisisEventItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.eventCountTxt");
         _icon = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.topEventImage");
         addChild(_countTxt);
         addChild(_icon);
      }
      
      public function set eventType(param1:int) : void
      {
         switch(param1)
         {
            case PlaneCrisisEventType.END_BOSS:
               _icon.resourceLink = "asset.planecrisis.topBigBoss";
               break;
            case PlaneCrisisEventType.TRAP_BOSS:
            case PlaneCrisisEventType.MIDDLE_BOSS:
               _icon.resourceLink = "asset.planecrisis.topSmallBoss";
               break;
            case PlaneCrisisEventType.DISPERSE_GOG:
               _icon.resourceLink = "asset.planecrisis.topCloud";
               break;
            case PlaneCrisisEventType.TREASURE_BOX:
               _icon.resourceLink = "asset.planecrisis.topBox";
               break;
            case PlaneCrisisEventType.KEY:
               _icon.resourceLink = "asset.planecrisis.topKey";
               break;
            case PlaneCrisisEventType.CRYSTAL:
               _icon.resourceLink = "asset.planecrisis.topElergment";
               break;
            case PlaneCrisisEventType.REWARD:
               _icon.resourceLink = "asset.planecrisis.topRewardBox";
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : PlaneCrisisCountInfo
      {
         return _data;
      }
      
      public function set data(param1:PlaneCrisisCountInfo) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:PlaneCrisisNodeInfo = null;
         _data = param1;
         if(_data != null)
         {
            _loc4_ = _data.maxCount - _data.currCount;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _countTxt.text = _loc4_ + "/" + _data.maxCount;
            if(param1.eventType == PlaneCrisisEventType.END_BOSS)
            {
               _countTxt.setFrame(3);
               _loc2_ = int(PlaneCrisisManager.Instance.endBossNodeId);
               _loc3_ = PlaneCrisisManager.Instance.model.nodeInfoDic[_loc2_];
               if(_loc3_ && _loc3_.eventTempInfo)
               {
                  _icon.tipData = _loc3_.eventTempInfo.Description;
               }
            }
            else
            {
               _icon.tipData = _data.getDescription();
               if(_data.currCount * 2 >= _data.maxCount)
               {
                  _countTxt.setFrame(2);
                  _icon.alpha = 0.6;
               }
               else
               {
                  _countTxt.setFrame(1);
                  _icon.alpha = 1;
               }
            }
         }
         else
         {
            _countTxt.text = "";
            _icon.tipData = null;
         }
      }
   }
}

