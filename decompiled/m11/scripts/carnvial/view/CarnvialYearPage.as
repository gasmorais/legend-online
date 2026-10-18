package carnvial.view
{
   import carnvial.item.CarnivalYearBigBox;
   import carnvial.item.CarnivalYearSmallBox;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.base.NumberBitmap;
   
   public class CarnvialYearPage extends BaseCarnivalPage
   {
      
      private var _nextPoint:NumberBitmap;
      
      private var _scoreDes:FilterFrameText;
      
      private var _myScore:NumberBitmap;
      
      private var _myScoreBg:Image;
      
      private var _pepole:Bitmap;
      
      private var _hPanel:HRollItemPanel;
      
      private var _dic:Dictionary = new Dictionary();
      
      private var _fullFlg:Bitmap;
      
      private const TYPE_YEAR:int = 1;
      
      private var _tempList:Array;
      
      public function CarnvialYearPage()
      {
         super();
         initData();
         initEvent();
         refreshView();
      }
      
      override protected function initView() : void
      {
         _pepole = new Bitmap();
         _scoreDes = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.yearScoreTxt");
         _nextPoint = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearNextNeed");
         _nextPoint.initParams("asset.carniver.yearNextTitle","asset.carniver.pointNum",18,22,15,18,"0123456789",143,4,0,64);
         _myScore = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearScoreBit");
         _myScore.initParams(null,"asset.carniver.pointNum",18,22,15,18,"0123456789",78,4,0,64);
         _myScoreBg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.yearScoreBg");
         _hPanel = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearRollPanel");
         _hPanel.initParams("ui.carnival.yearRollPanel.HBox","ui.carnival.yearRollPanel.LeftBtn","ui.carnival.yearRollPanel.RightBtn",3,173,416,5);
         _fullFlg = ComponentFactory.Instance.creatBitmap("asset.carniver.fullGet");
         addChild(_pepole);
         addChild(_nextPoint);
         addChild(_myScoreBg);
         addChild(_myScore);
         addChild(_scoreDes);
         addChild(_hPanel);
         addChild(_fullFlg);
         _scoreDes.text = LanguageMgr.GetTranslation("discountshop.frame.myIntegral");
         _myScore.num = 0;
         _nextPoint.num = 0;
         toLoadImg(_pepole,"tab1_role",_activeId);
      }
      
      private function initData() : void
      {
         var _loc6_:CarnivalPointExchangeTemplateInfo = null;
         var _loc2_:CarnivalYearSmallBox = null;
         var _loc4_:CarnivalYearBigBox = null;
         var _loc3_:Sprite = null;
         var _loc7_:int = 0;
         _tempList = TempleteManager.instance.carnivalPointExchangeCate.getTempListByType(1);
         var _loc5_:int = int(_tempList ? _tempList.length : 0);
         var _loc1_:Array = [];
         var _loc8_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = _tempList[_loc7_];
            if(_loc6_.specialType != 1)
            {
               _loc4_ = new CarnivalYearBigBox();
               _loc4_.temp = _loc6_;
               _loc1_.push(_loc4_);
               _dic[_loc6_.Id] = _loc4_;
               _loc8_ = 2;
            }
            else
            {
               if(_loc3_)
               {
                  if(++_loc8_ >= 2)
                  {
                     _loc8_ = 0;
                     _loc3_ = new Sprite();
                     _loc1_.push(_loc3_);
                  }
               }
               else
               {
                  _loc8_ = 0;
                  _loc3_ = new Sprite();
                  _loc1_.push(_loc3_);
               }
               _loc2_ = new CarnivalYearSmallBox();
               _loc2_.temp = _loc6_;
               if(_loc3_.numChildren > 0)
               {
                  _loc2_.y = 210;
               }
               _loc3_.addChild(_loc2_);
               _dic[_loc6_.Id] = _loc2_;
            }
            _loc7_++;
         }
         _hPanel.updateList(_loc1_);
      }
      
      private function refreshView() : void
      {
         var _loc3_:CarnivalPointExchangeTemplateInfo = null;
         var _loc1_:CarnivalPointExchangeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(model.score);
         _myScore.num = _loc5_;
         var _loc2_:int = int(_tempList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _tempList[_loc4_];
            if(_loc3_.Target > _loc5_ && !_loc1_)
            {
               _loc1_ = _loc3_;
            }
            _dic[_loc3_.Id].refreshView();
            _loc4_++;
         }
         if(_loc1_ == null)
         {
            _fullFlg.visible = true;
            _nextPoint.visible = false;
         }
         else
         {
            _fullFlg.visible = false;
            _nextPoint.visible = true;
            _nextPoint.num = _loc1_.Target - _loc5_;
         }
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      override protected function clearView() : void
      {
         for each(var _loc1_:DisplayObject in _dic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _dic = null;
         ObjectUtils.disposeObject(_pepole);
         _pepole = null;
         ObjectUtils.disposeObject(_nextPoint);
         _nextPoint = null;
         ObjectUtils.disposeObject(_myScore);
         _myScore = null;
         ObjectUtils.disposeObject(_scoreDes);
         _scoreDes = null;
         ObjectUtils.disposeObject(_hPanel);
         _hPanel = null;
         ObjectUtils.disposeObject(_fullFlg);
         _fullFlg = null;
         ObjectUtils.disposeObject(_myScoreBg);
         _myScoreBg = null;
      }
   }
}

