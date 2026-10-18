package lordtrial.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.LordTrialTempInfo;
   
   public class LordTrialRankRewardTipItem extends Component
   {
      
      private var _typeTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _data:LordTrialTempInfo;
      
      private var _type:int;
      
      private var _rewardGoodsTempIdArr:Array;
      
      private var _len:int;
      
      private var _rankStr:String;
      
      public function LordTrialRankRewardTipItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _typeTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankRewardTipItem.typeTxt");
         _vbox = new VBox();
         _vbox.spacing = 2;
         _vbox.x = 80;
         addChild(_typeTxt);
         addChild(_vbox);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_typeTxt);
         _typeTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         _typeTxt.text = LanguageMgr.GetTranslation("lordtrial.rank.typeTxt" + _type);
      }
      
      public function set data(param1:LordTrialTempInfo) : void
      {
         var _loc3_:FilterFrameText = null;
         var _loc7_:GoodsInfo = null;
         var _loc2_:FilterFrameText = null;
         var _loc4_:Sprite = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         if(param1)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankRewardTipView.rankTxt");
            if(param1.para2 != _rankStr)
            {
               _rankStr = param1.para2;
               if(param1.para2)
               {
                  _loc5_ = param1.para2.split(",");
               }
               if(_loc5_ && _loc5_.length == 1)
               {
                  _loc6_ = _loc5_[0];
               }
               else if(_loc5_ && _loc5_.length == 2)
               {
                  _loc6_ = _loc5_[0] + "-" + _loc5_[1];
               }
               _loc3_.text = LanguageMgr.GetTranslation("lordTrialRankRewardTipView.rankTxt",_loc6_);
            }
            else
            {
               _loc3_.text = "";
            }
            _loc4_ = new Sprite();
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankRewardTipItem.rewardTxt");
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = param1.itemId;
            _loc2_.text = _loc7_.templateInfo.TemplateName + "*" + param1.count;
            _loc4_.addChild(_loc3_);
            _loc4_.addChild(_loc2_);
            _vbox.addChild(_loc4_);
         }
      }
      
      override public function dispose() : void
      {
         uninitView();
         super.dispose();
      }
   }
}

