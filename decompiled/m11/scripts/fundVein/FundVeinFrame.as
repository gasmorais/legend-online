package fundVein
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.FundManager;
   import managers.FundVeinManager;
   import mvc.module.fundVein.FundVeinInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.base.ViewBaseFrame;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class FundVeinFrame extends ViewBaseFrame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _items:Vector.<FundVeinItem>;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _helpBtn:BaseButton;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _totalTxt:GradientText;
      
      private var _diamondCells:Vector.<FundVeinDiamondCell>;
      
      private const CELL_AMOUNT:int = 3;
      
      public function FundVeinFrame()
      {
         super();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         FundVeinManager.instance.fundOperate(0);
         FundManager.instance.isNewbie = true;
      }
      
      override protected function initView() : void
      {
         var _loc1_:FundVeinItem = null;
         var _loc6_:int = 0;
         this.titleText = LanguageMgr.GetTranslation("fund.FundNewbieFrame.titleText");
         _bg = creatComponentByStylename("fund.bg4");
         addToContent(_bg);
         _bottomBg = creatComponentByStylename("fund.bottomBg");
         addToContent(_bottomBg);
         _helpBtn = creatComponentByStylename("fundVein.HelpBtn");
         addToContent(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("fund.FundNewbieFrame.helpFrame.helpTitle");
         _tipsTxt = creatComponentByStylename("fund.bottomTipsTxt");
         addToContent(_tipsTxt);
         var _loc3_:String = "<font color=\'#ff0000\' size=\'13\'><b>" + LanguageMgr.GetTranslation("gvg.InwarTips") + "</b></font> ";
         _loc3_ += LanguageMgr.GetTranslation("fund.fundVein.frameBottomTips.text");
         _tipsTxt.htmlText = _loc3_;
         _totalTxt = creatComponentByStylename("fund.totalGet");
         _totalTxt.text = LanguageMgr.GetTranslation("fund.FundRewardView.totalGet.text");
         addToContent(_totalTxt);
         _items = new Vector.<FundVeinItem>(3);
         var _loc2_:int = _bg.x + 4;
         var _loc5_:int = _bg.y + 4;
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc1_ = new FundVeinItem(_loc6_);
            _loc1_.x = 284 * _loc6_ + _loc2_;
            _loc1_.y = _loc5_;
            addToContent(_loc1_);
            _items[_loc6_] = _loc1_;
            _loc6_++;
         }
         _diamondCells = new Vector.<FundVeinDiamondCell>(2);
         var _loc4_:FundVeinDiamondCell = new FundVeinDiamondCell(460,false,2,true);
         _loc4_.y = 605;
         addToContent(_loc4_);
         _diamondCells[0] = _loc4_;
         _loc4_ = new FundVeinDiamondCell(550,true,2,true);
         _loc4_.y = 605;
         addToContent(_loc4_);
         _diamondCells[1] = _loc4_;
      }
      
      override protected function initEvent(param1:Boolean = true) : void
      {
         if(param1)
         {
            _helpBtn.addEventListener("click",__helpBtnClickHandler);
            NotificationManager.instance.addEventListener("FUND_VEIN_INFO_REFRESH",__viewRefreshHanlder);
         }
         else
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
            NotificationManager.instance.removeEventListener("FUND_VEIN_INFO_REFRESH",__viewRefreshHanlder);
         }
         super.initEvent(param1);
      }
      
      private function __viewRefreshHanlder(param1:Event) : void
      {
         var _loc2_:FundVeinInfo = FundVeinManager.instance.info;
         if(_loc2_.isOver)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04"));
            dispose();
            return;
         }
         updateView(_loc2_);
      }
      
      public function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("fund.NewbieRewardHelpFrame");
         _loc2_.show();
      }
      
      private function updateView(param1:FundVeinInfo) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = param1.leveInfo;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _items[_loc3_].updateView(_loc5_[_loc3_]);
            _loc3_++;
         }
         var _loc2_:Array = param1.totalTakedInfo;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _diamondCells[_loc4_].updateView(_loc2_[_loc4_]);
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:Disposeable = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         FundManager.instance.isNewbie = false;
         initEvent(false);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeAllGrandson(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_totalTxt);
         _totalTxt = null;
         _loc2_ = _items.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = _items.pop();
            _loc1_.dispose();
            _loc2_--;
         }
         _items = null;
         _loc3_ = _diamondCells.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = _diamondCells.pop();
            _loc1_.dispose();
            _loc3_--;
         }
         _diamondCells = null;
         super.dispose();
         ObjectUtils.disposeSelf(this);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,710);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

