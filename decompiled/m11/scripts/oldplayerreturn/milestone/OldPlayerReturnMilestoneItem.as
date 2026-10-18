package oldplayerreturn.milestone
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.templates.OldPlayerReturnRewardTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   
   public class OldPlayerReturnMilestoneItem extends Component
   {
      
      public static const DEFAULT:int = 1;
      
      public static const OPEN:int = 2;
      
      public static const CLOSE:int = 3;
      
      private var _bg:Bitmap;
      
      private var _icon:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _numTxt:GradientText;
      
      private var _data:OldPlayerReturnRewardTempInfo;
      
      public function OldPlayerReturnMilestoneItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnMilestoneItem.bg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnMilestoneItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnMilestoneItem.titleTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnMilestoneItem.numTxt");
         addChild(_bg);
         addChild(_icon);
         addChild(_txt);
         addChild(_numTxt);
         _icon.setFrame(1);
         _txt.text = LanguageMgr.GetTranslation("OldPlayerReturnMilestoneItem.txt.text");
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
         _icon.setFrame(param1);
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
         _numTxt.text = _data.NeedCount.toString();
         var _loc2_:String = getRewardTipsStr(_data.rewardsArr);
         this.tipData = _loc2_;
         var _loc3_:Array = model.milestoneProcess.split("|");
         var _loc4_:int = int(_loc3_[_data.RewardNum - 1]);
         if(_loc4_ == 0)
         {
            if(_data.NeedCount <= model.milestoneScore)
            {
               state = 2;
            }
            else
            {
               state = 1;
            }
         }
         else if(_loc4_ == 1)
         {
            state = 3;
         }
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
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

