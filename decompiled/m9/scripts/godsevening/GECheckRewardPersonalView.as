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
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class GECheckRewardPersonalView extends Component
   {
      
      private const GOODS_ID:int = -11000;
      
      private var _bg:Image;
      
      private var _prize1:Image;
      
      private var _prize2:GradientText;
      
      private var _prize3:GradientText;
      
      private var _prize4:FilterFrameText;
      
      private var _prize5:FilterFrameText;
      
      private var _prize6:FilterFrameText;
      
      private var _prize7:FilterFrameText;
      
      private var _prizeArr:Array = [];
      
      private var _rankArr:Array = [4,10,11,20,21,50,51,100];
      
      public function GECheckRewardPersonalView()
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
         _prize6 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize6");
         _prize7 = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.Prize7");
         addChild(_bg);
         addChild(_prize1);
         addChild(_prize2);
         addChild(_prize3);
         addChild(_prize4);
         addChild(_prize5);
         addChild(_prize6);
         addChild(_prize7);
         _prize2.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize2");
         _prize3.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize3");
         _prize4.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize4",_rankArr[0],_rankArr[1]);
         _prize5.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize4",_rankArr[2],_rankArr[3]);
         _prize6.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize4",_rankArr[4],_rankArr[5]);
         _prize7.text = LanguageMgr.GetTranslation("godsEvening.GECheckRewardServerView.prize4",_rankArr[6],_rankArr[7]);
         addRewards();
      }
      
      private function addRewards() : void
      {
         var _loc3_:BaseItemView = null;
         var _loc4_:FilterFrameText = null;
         var _loc1_:GoodsInfo = null;
         var _loc2_:int = 0;
         var _loc5_:TextButton = null;
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.RewardItemText");
            switch(_loc2_)
            {
               case 0:
                  _loc1_ = new GoodsInfo();
                  _loc1_.templateId = -11000;
                  _loc3_.data = _loc1_ as GoodsInfo;
                  _loc4_.htmlText = "<font color=\'" + GoodsSonType.getColorByProfile(4) + "\'>" + _loc1_.templateInfo.TemplateName + "*" + getGoodsCount(1) + "</font>";
                  break;
               case 1:
                  _loc3_.icon.icon = IconFactory.getCommonIconPath("/lordappell.png");
                  _loc3_.icon.tipStyle = "yishi.view.tips.OneLineTip";
                  _loc3_.icon.tipData = LanguageMgr.GetTranslation("godsEvening.GECheckRewardPersonalView.appell");
                  _loc3_.profile = 5;
                  _loc4_.htmlText = "<font color=\'" + GoodsSonType.getColorByProfile(5) + "\'>" + LanguageMgr.GetTranslation("godsEvening.GECheckRewardPersonalView.appell") + "</font>";
            }
            _loc3_.x = 260 + _loc2_ * 100;
            _loc3_.y = 55;
            _loc4_.x = _loc3_.x + (_loc3_.displayWidth - _loc4_.width) / 2;
            _loc4_.y = _loc3_.y + _loc3_.displayHeight;
            addChild(_loc3_);
            addChild(_loc4_);
            _prizeArr.push(_loc3_);
            _prizeArr.push(_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardServerView.RewardBtn");
            _loc5_.x = 120;
            if(_loc2_ == 2 || _loc2_ == 3)
            {
               _loc5_.x = 150;
            }
            if(_loc2_ == 4 || _loc2_ == 5)
            {
               _loc5_.x = 165;
            }
            if(_loc2_ == 6 || _loc2_ == 7)
            {
               _loc5_.x = 280;
            }
            _loc5_.y = 138 + _loc2_ % 6 * 25;
            if(_loc2_ < 6)
            {
               _loc1_ = new GoodsInfo();
               _loc1_.templateId = -11000;
               _loc5_.text = "<font color=\'" + GoodsSonType.getColorByProfile(4) + "\'>" + _loc1_.templateInfo.TemplateName + "*" + getGoodsCount(_loc2_ + 2) + "</font>";
               _loc5_.tipStyle = "yishi.view.tips.goods.PropTips";
               _loc5_.tipData = _loc1_;
            }
            else
            {
               _loc5_.tipStyle = "yishi.view.tips.OneLineTip";
               _loc5_.tipData = LanguageMgr.GetTranslation("godsEvening.GECheckRewardPersonalView.appell");
               _loc5_.text = "<font color=\'" + GoodsSonType.getColorByProfile(5) + "\'>" + LanguageMgr.GetTranslation("godsEvening.GECheckRewardPersonalView.appell") + "</font>";
            }
            addChild(_loc5_);
            _prizeArr.push(_loc5_);
            _loc2_++;
         }
      }
      
      private function getGoodsCount(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 9500;
               break;
            case 1:
               _loc2_ = 8000;
               break;
            case 2:
               _loc2_ = 7000;
               break;
            case 3:
               _loc2_ = 5500;
               break;
            case 4:
               _loc2_ = 4500;
               break;
            case 5:
               _loc2_ = 3000;
               break;
            case 6:
               _loc2_ = 2000;
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
         ObjectUtils.disposeObject(_prize6);
         _prize6 = null;
         ObjectUtils.disposeObject(_prize7);
         _prize7 = null;
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

