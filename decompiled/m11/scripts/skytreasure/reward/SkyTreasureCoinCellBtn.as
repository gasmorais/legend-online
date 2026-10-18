package skytreasure.reward
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   import yishi.utils.MsgMan;
   
   public class SkyTreasureCoinCellBtn extends Sprite
   {
      
      protected var _LotteryBack1:Bitmap;
      
      protected var _LotteryBack:Bitmap;
      
      protected var _lunpaihangName:FilterFrameText;
      
      protected var _lunpaihangicon:Bitmap;
      
      private var _type:int = 0;
      
      private var _showVBox:VBox;
      
      private var _select:Boolean = false;
      
      private var _rankView:SkymyrankItem;
      
      private var _data:SkyTreasureActTemplateInfo;
      
      public function SkyTreasureCoinCellBtn()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("skylun.ShowInfoVBox");
         _LotteryBack1 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.LotteryBack1");
         _LotteryBack = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.LotteryBack");
         _lunpaihangName = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.lunpaihangName");
         _lunpaihangicon = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.lunpaihangicon");
         _LotteryBack1.visible = false;
         addChild(_LotteryBack1);
         addChild(_LotteryBack);
         _LotteryBack1.width = _LotteryBack.width = 725;
         addChild(_lunpaihangName);
         addChild(_lunpaihangicon);
         _lunpaihangName.mouseEnabled = true;
         addChild(_showVBox);
      }
      
      private function addEvent() : void
      {
         _lunpaihangName.addEventListener("click",Upselect);
      }
      
      private function Upselect(param1:MouseEvent) : void
      {
         select = !_select;
      }
      
      public function set select(param1:Boolean) : void
      {
         _select = param1;
         _LotteryBack1.visible = param1;
         _LotteryBack.visible = !param1;
         _lunpaihangicon.scaleY = param1 ? -1 : 1;
         _lunpaihangicon.y = param1 ? 23 : 13;
         refreshShowInfo();
      }
      
      public function set data(param1:SkyTreasureActTemplateInfo) : void
      {
         _data = param1;
         _lunpaihangName.text = _data.actDesc;
      }
      
      private function get model() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      public function refreshShowInfo() : void
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc5_:SkyTreasureCoinRewardItem = null;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         if(_select)
         {
            _loc4_ = [];
            _showVBox.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < _data.skyTreasureRankRewardArray.length)
            {
               _loc5_ = new SkyTreasureCoinRewardItem();
               _loc5_.data = _data.skyTreasureRankRewardArray[_loc2_];
               _showVBox.addChild(_loc5_);
               _loc2_++;
            }
            _showVBox.commitChanges();
            _rankView = new SkymyrankItem();
            _rankView.y = 376;
            if(_data.isActShow)
            {
               if(model.roundRankInfo)
               {
                  _rankView.update(model.roundRankInfo.myRank,model.roundRankInfo.myGrade);
               }
            }
            else
            {
               _loc1_ = model.skyTreasureRankRecordInfoArray;
               _loc3_ = 0;
               while(_loc3_ < _loc1_.length)
               {
                  if(_loc1_[_loc3_].actId == _data.actId)
                  {
                     _rankView.update(_loc1_[_loc3_].myRank,_loc1_[_loc3_].myscore);
                  }
                  _loc3_++;
               }
            }
            addChild(_rankView);
         }
         else
         {
            _showVBox.removeAllChild();
            _showVBox.disposeAllChildren();
            _rankView.dispose();
         }
         MsgMan.notifyObserver("SkyTreasureCoinCellBtn");
      }
      
      private function remEvent() : void
      {
         _lunpaihangName.removeEventListener("click",Upselect);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_LotteryBack1);
         _LotteryBack1 = null;
         ObjectUtils.disposeObject(_LotteryBack);
         _LotteryBack = null;
         ObjectUtils.disposeObject(_lunpaihangName);
         _lunpaihangName = null;
         ObjectUtils.disposeObject(_lunpaihangicon);
         _lunpaihangicon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

