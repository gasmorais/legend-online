package auction.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TitleButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class AuctionListTitleComponent extends Sprite implements Disposeable
   {
      
      private var _backStyle:String;
      
      private var _backView:DisplayObject;
      
      private var _columnWidths:Array;
      
      private var _columnXs:Array;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _titleIcon:TitleButton;
      
      private var _titleName:TitleButton;
      
      private var _titleGrade:TitleButton;
      
      private var _titleTime:TitleButton;
      
      private var _titleMan:TitleButton;
      
      private var _titlePrice:TitleButton;
      
      private var _titleCurPrice:TitleButton;
      
      private var _curSelectBtn:TitleButton;
      
      public function AuctionListTitleComponent(param1:String, param2:Array, param3:Array, param4:Number = 3, param5:Number = 6)
      {
         _backStyle = param1;
         _columnWidths = param2;
         _columnXs = param3;
         _startX = param4;
         _startY = param5;
         initView();
         super();
      }
      
      private function initView() : void
      {
         _backView = ComponentFactory.Instance.creatComponentByStylename(_backStyle);
         addChild(_backView);
         _titleIcon = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleIcon");
         _titleIcon.width = _columnWidths[0];
         _titleIcon.x = _columnXs[0];
         _titleName = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleName");
         _titleName.width = _columnWidths[1];
         _titleName.x = _columnXs[1];
         _titleGrade = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleGrade");
         _titleGrade.width = _columnWidths[2];
         _titleGrade.x = _columnXs[2];
         _titleGrade.buttonMode = true;
         _titleGrade.addMouseEffect();
         _titleTime = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleTime");
         _titleTime.width = _columnWidths[3];
         _titleTime.x = _columnXs[3];
         _titleTime.buttonMode = true;
         _titleTime.addMouseEffect();
         _titleMan = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleMan");
         _titleMan.width = _columnWidths[4];
         _titleMan.x = _columnXs[4];
         _titlePrice = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitlePrice");
         _titlePrice.width = _columnWidths[5];
         _titlePrice.x = _columnXs[5];
         _titlePrice.buttonMode = true;
         _titlePrice.addMouseEffect();
         _titleCurPrice = ComponentFactory.Instance.creatComponentByStylename("auction.ListTitleCurPrice");
         _titleCurPrice.width = _columnWidths[6];
         _titleCurPrice.x = _columnXs[6];
         _titleCurPrice.buttonMode = true;
         _titleCurPrice.addMouseEffect();
         addChild(_titleIcon);
         _titleIcon.text = LanguageMgr.GetTranslation("Auction.ResultListTitle1");
         addChild(_titleName);
         _titleName.text = LanguageMgr.GetTranslation("Auction.ResultListTitle2");
         addChild(_titleGrade);
         _titleGrade.text = LanguageMgr.GetTranslation("public.grade");
         addChild(_titleTime);
         _titleTime.text = LanguageMgr.GetTranslation("Auction.ResultListTitle4");
         addChild(_titleMan);
         _titleMan.text = LanguageMgr.GetTranslation("Auction.ResultListTitle5");
         addChild(_titlePrice);
         _titlePrice.text = LanguageMgr.GetTranslation("Auction.ResultListTitle6");
         addChild(_titleCurPrice);
         _titleCurPrice.text = LanguageMgr.GetTranslation("Auction.ResultListTitle7");
      }
      
      public function get titleGrade() : TitleButton
      {
         return _titleGrade;
      }
      
      public function get titleTime() : TitleButton
      {
         return _titleTime;
      }
      
      public function get titlePrice() : TitleButton
      {
         return _titlePrice;
      }
      
      public function get titleCurPrice() : TitleButton
      {
         return _titleCurPrice;
      }
      
      public function currentSelectBut(param1:TitleButton) : int
      {
         _titleIcon.setFrame = 0;
         _titleName.setFrame = 0;
         _titleGrade.setFrame = 0;
         _titleTime.setFrame = 0;
         _titleMan.setFrame = 0;
         _titlePrice.setFrame = 0;
         _titleCurPrice.setFrame = 0;
         if(param1 == null)
         {
            _curSelectBtn = null;
            return 1;
         }
         if(_curSelectBtn == param1)
         {
            param1.setFrame = 2;
            _curSelectBtn = null;
            return 2;
         }
         param1.setFrame = 1;
         _curSelectBtn = param1;
         return 1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

