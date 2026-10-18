package oldplayerreturn.task
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.templates.OldPlayerReturnRewardTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   
   public class OldPlayerReturnTaskBoxItem extends Component
   {
      
      public static const DEFAULT:int = 1;
      
      public static const OPEN:int = 2;
      
      public static const CLOSE:int = 3;
      
      private var _dayBg:ScaleFrameImage;
      
      private var _weekBg:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _data:OldPlayerReturnRewardTempInfo;
      
      public function OldPlayerReturnTaskBoxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dayBg = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskBoxItem.dayBg");
         _weekBg = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskBoxItem.weekBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskBoxItem.txt");
         addChild(_dayBg);
         addChild(_weekBg);
         addChild(_txt);
         _dayBg.setFrame(1);
         _weekBg.setFrame(1);
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 75;
         tipGapH = 75;
         isFollowMouse = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         OldPlayerReturnManager.instance.send(1,_data.RewardNum - 1,_data.RewardType);
      }
      
      public function set state(param1:int) : void
      {
         removeEvent();
         buttonMode = false;
         _dayBg.setFrame(param1);
         _weekBg.setFrame(param1);
         if(param1 == 2)
         {
            buttonMode = true;
            addEvent();
         }
      }
      
      public function set data(param1:OldPlayerReturnRewardTempInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(isDay)
         {
            _dayBg.visible = true;
            _weekBg.visible = false;
         }
         else
         {
            _dayBg.visible = false;
            _weekBg.visible = true;
         }
         _txt.text = _data.NeedCount.toString();
         var _loc2_:String = getRewardTipsStr(_data.rewardsArr);
         this.tipData = _loc2_;
         var _loc4_:int = int(isDay ? model.dailyNum : int(model.weekNum));
         var _loc6_:String = isDay ? model.dailyProcess : model.weekProcess;
         var _loc3_:Array = _loc6_.split("|");
         var _loc5_:int = int(_loc3_[_data.RewardNum - 1]);
         if(_loc5_ == 0)
         {
            if(_data.NeedCount <= _loc4_)
            {
               state = 2;
            }
            else
            {
               state = 1;
            }
         }
         else if(_loc5_ == 1)
         {
            state = 3;
         }
      }
      
      private function get isDay() : Boolean
      {
         return _data.RewardType == 1;
      }
      
      private function getRewardTipsStr(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(param1 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(_loc3_ == param1.length - 1)
               {
                  _loc2_ += getGoodsName(param1[_loc3_].itemId) + "*" + param1[_loc3_].count;
               }
               else
               {
                  _loc2_ += getGoodsName(param1[_loc3_].itemId) + "*" + param1[_loc3_].count + ",\n";
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_dayBg);
         _dayBg = null;
         ObjectUtils.disposeObject(_weekBg);
         _weekBg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

