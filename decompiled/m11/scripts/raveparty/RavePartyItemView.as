package raveparty
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import utils.LogicUtils;
   import yishi.view.base.ProgressCommon;
   
   public class RavePartyItemView extends Component
   {
      
      private var back:MutipleImage;
      
      private var titleImage:ScaleFrameImage;
      
      private var progressBar:ProgressCommon;
      
      private var curScoreText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var boxHbox:HBox;
      
      private var itemList:Vector.<RavePartyBoxImage>;
      
      private var showType:int;
      
      private var myCurPoint:int;
      
      private var _data:RavePartyRewardInfo;
      
      private var curShowList:Array;
      
      public function RavePartyItemView(param1:int)
      {
         super();
         showType = param1;
         initView();
         initBoxListView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("RavePartyItemView.back");
         titleImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyItemView.titleImage");
         progressBar = ComponentFactory.Instance.creatComponentByStylename("RavePartyItemView.progressBar");
         curScoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartyItemView.curScoreText");
         descText = ComponentFactory.Instance.creatComponentByStylename("RavePartyItemView.descText");
         boxHbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyItemView.boxHbox");
         addChild(back);
         addChild(titleImage);
         addChild(progressBar);
         addChild(curScoreText);
         addChild(descText);
         addChild(boxHbox);
         titleImage.setFrame(showType);
         setDescText();
      }
      
      private function initBoxListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RavePartyBoxImage = null;
         itemList = new Vector.<RavePartyBoxImage>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new RavePartyBoxImage(_loc2_ + 1);
            boxHbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function setDescText() : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         var _loc1_:String = "";
         if(showType == 1)
         {
            _loc2_ += model.chargeScoreSet.split("|")[0];
            _loc1_ += model.chargeScoreSet.split("|")[1];
            curShowList = model.chargeRewardList;
            myCurPoint = model.myChargePoint;
         }
         else if(showType == 2)
         {
            _loc2_ += model.consumScoreSet.split("|")[0];
            _loc1_ += model.consumScoreSet.split("|")[1];
            curShowList = model.consumRewardList;
            myCurPoint = model.myConsumPoint;
         }
         else if(showType == 3)
         {
            curShowList = model.leedsRewardList;
            myCurPoint = model.myLeedScore;
         }
         descText.text = LanguageMgr.GetTranslation("RavePartyItemView.descText.text" + showType,_loc2_,_loc1_);
         if(showType == 3)
         {
            curScoreText.text = LanguageMgr.GetTranslation("RavePartyItemView.curScoreText.text2",myCurPoint);
         }
         else
         {
            _loc3_ = Math.floor(myCurPoint * int(_loc1_) / int(_loc2_));
            curScoreText.text = LanguageMgr.GetTranslation("RavePartyItemView.curScoreText.text1",_loc3_);
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RavePartyBoxImage = null;
         setDescText();
         _loc2_ = 0;
         while(_loc2_ < itemList.length)
         {
            _loc1_ = itemList[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new RavePartyBoxImage(_loc2_ + 1);
               itemList[_loc2_] = _loc1_;
            }
            _loc1_.data = _loc2_ < curShowList.length ? curShowList[_loc2_] : null;
            _loc2_++;
         }
         progressBar.value = process;
         progressBar.text = "";
      }
      
      private function get process() : Number
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         var _loc1_:Array = model.getCurGradeAndMaxData(myCurPoint,curShowList);
         if(_loc1_.length <= 0)
         {
            return 0;
         }
         var _loc3_:int = _loc1_[0] - 1;
         if(_loc3_ <= 0)
         {
            _loc2_ = int(curShowList[_loc3_].needValue);
            _loc5_ = myCurPoint;
         }
         else
         {
            _loc2_ = curShowList[_loc3_].needValue - curShowList[_loc3_ - 1].needValue;
            _loc5_ = myCurPoint - curShowList[_loc3_ - 1].needValue;
         }
         _loc4_ = _loc5_ >= _loc2_ ? 1 : _loc5_ / _loc2_;
         return 0.2 * (_loc3_ + _loc4_);
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(titleImage)
         {
            ObjectUtils.disposeObject(titleImage);
         }
         titleImage = null;
         if(curScoreText)
         {
            ObjectUtils.disposeObject(curScoreText);
         }
         curScoreText = null;
         if(descText)
         {
            ObjectUtils.disposeObject(descText);
         }
         descText = null;
         if(progressBar)
         {
            ObjectUtils.disposeObject(progressBar);
         }
         progressBar = null;
         if(boxHbox)
         {
            ObjectUtils.disposeObject(boxHbox);
         }
         boxHbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         super.dispose();
      }
   }
}

