package godsevening
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class GECheckRewardServerView extends Component
   {
      
      private var _bg:Image;
      
      private var _prize1:Image;
      
      private var _prize2:GradientText;
      
      private var _prize3:GradientText;
      
      private var _prize4:FilterFrameText;
      
      private var _prize5:FilterFrameText;
      
      private var _prizeArr:Array = [];
      
      private var _rankArr:Array = [4,6,7,10];
      
      public function GECheckRewardServerView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Bg");
         _prize1 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize1");
         _prize2 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize2");
         _prize3 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize3");
         _prize4 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize4");
         _prize5 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize5");
         addChild(_bg);
         addChild(_prize1);
         addChild(_prize2);
         addChild(_prize3);
         addChild(_prize4);
         addChild(_prize5);
         _prize2.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize2");
         _prize3.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize3");
         _prize4.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize4",_rankArr[0],_rankArr[1]);
         _prize5.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize4",_rankArr[2],_rankArr[3]);
         addRewards();
      }
      
      private function addRewards() : void
      {
         var _loc4_:BaseItemView = null;
         var _loc5_:FilterFrameText = null;
         var _loc7_:Object = null;
         var _loc2_:int = 0;
         var _loc6_:TextButton = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 1)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.RewardItemText");
            switch(_loc2_)
            {
               case 0:
                  _loc7_ = {};
                  _loc7_.itemName = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.rewardItemTxt0");
                  _loc7_.des = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.rewardItemTxtDes0",14);
                  _loc4_.icon.icon = IconFactory.getCommonIconPath("/ragnarok_buff.png");
                  _loc4_.icon.tipStyle = "yishi.view.tips.goods.TmpTips";
                  _loc4_.icon.tipData = _loc7_;
                  _loc4_.profile = 5;
                  _loc5_.htmlText = "<font color=\'" + GoodsSonType.getColorByProfile(5) + "\'>" + LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.rewardItemTxt" + _loc2_) + "</font>";
            }
            _loc4_.x = 260 + _loc2_ * 100;
            _loc4_.y = 55;
            _loc5_.x = _loc4_.x + (_loc4_.displayWidth - _loc5_.width) / 2;
            _loc5_.y = _loc4_.y + _loc4_.displayHeight;
            addChild(_loc4_);
            addChild(_loc5_);
            _prizeArr.push(_loc4_);
            _prizeArr.push(_loc5_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc7_ = {};
            _loc1_ = _loc2_ < 2 ? 5 : 4;
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.RewardBtn");
            _loc6_.x = 120;
            if(_loc2_ > 1)
            {
               _loc6_.x = 150;
            }
            _loc6_.y = 138 + _loc2_ % 4 * 25;
            _loc7_.itemName = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.rewardBtnTxt0",getDays(_loc2_));
            _loc7_.des = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.rewardItemTxtDes0",getDays(_loc2_));
            _loc6_.text = "<font color=\'" + GoodsSonType.getColorByProfile(_loc1_) + "\'>" + LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.rewardBtnTxt" + _loc3_,getDays(_loc2_)) + "</font>";
            _loc6_.tipData = _loc7_;
            addChild(_loc6_);
            _prizeArr.push(_loc6_);
            _loc2_++;
         }
      }
      
      private function getDays(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 10;
               break;
            case 1:
               _loc2_ = 7;
               break;
            case 2:
               _loc2_ = 5;
               break;
            case 3:
               _loc2_ = 3;
               break;
            case 4:
               _loc2_ = 2;
               break;
            case 5:
               _loc2_ = 1;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_prize1);
         _prize1 = null;
         ObjectUtils.disposeObject(_prize2);
         _prize2 = null;
         ObjectUtils.disposeObject(_prize3);
         _prize3 = null;
         ObjectUtils.disposeObject(_prize4);
         _prize4 = null;
         ObjectUtils.disposeObject(_prize5);
         _prize5 = null;
         for each(var _loc1_:Object in _prizeArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      override public function dispose() : void
      {
         unInitView();
         super.dispose();
      }
   }
}

