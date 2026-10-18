package christmas
{
   import avatar.view.AppellView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.appell.AppellModel;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class ChristmasPrayPreviewFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bg1:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _appellName:Bitmap;
      
      private var _appellAtt:Bitmap;
      
      private var _index:int;
      
      private var _appellContainer:Component;
      
      private var _appellTopView:AppellView;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      public function ChristmasPrayPreviewFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,354,303);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ChristmasPrayPreviewFrame.titleText.txt");
         _border = ComponentFactory.Instance.creatComponentByStylename("christmasPrayPreviewFrame.border");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.bg1");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.bg2");
         _appellName = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.appellName");
         _appellAtt = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.appellAtt");
         _appellContainer = new Component();
         _appellContainer.x = 0;
         _appellContainer.y = 70;
         _propertyTxt = ComponentFactory.Instance.creatComponentByStylename("christmasPrayPreviewFrame.propertyTxt");
         _panel = ComponentFactory.Instance.creatComponentByStylename("christmasPrayPreviewFrame.scollPanel");
         _vbox = ComponentFactory.Instance.creatCustomObject("christmasPrayPreviewFrame.vBox");
         addToContent(_border);
         addToContent(_bg2);
         addToContent(_panel);
         addToContent(_bg1);
         addToContent(_appellName);
         addToContent(_appellAtt);
         addToContent(_appellContainer);
         addToContent(_propertyTxt);
         _panel.setView(_vbox);
         initData();
      }
      
      private function initData() : void
      {
         var _loc4_:int = 0;
         var _loc2_:ChristmasPrayPreviewItem = null;
         _panel.beginChanges();
         _vbox.beginChanges();
         var _loc1_:Array = TempleteManager.instance.christmasLotteryTempCate.getTemplatesByType(2);
         var _loc3_:int = Math.ceil(_loc1_.length / 5);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ChristmasPrayPreviewItem(_loc4_ + 1);
            _vbox.addChild(_loc2_);
            _loc4_++;
         }
         _vbox.commitChanges();
         _panel.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      public function refreshView() : void
      {
         var _loc12_:ChristmasActivitiesTempInfo = null;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc3_:AppellInfoTemplate = null;
         var _loc9_:AppellModel = null;
         var _loc2_:String = null;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc11_:Array = null;
         var _loc10_:int = 0;
         _bg1.visible = _appellName.visible = _appellAtt.visible = _appellContainer.visible = _propertyTxt.visible = _index == 0;
         _panel.visible = _index == 1;
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(1);
         if(_loc1_.length > 0)
         {
            _loc12_ = _loc1_[0];
            if(_loc12_)
            {
               _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.Reward1);
               if(_loc7_ && _loc7_.SonType == 221)
               {
                  _loc4_ = int(_loc7_.Property1);
                  _loc9_ = FrameControllerManager.instance.appellControler.model;
                  if(_loc9_ && _loc9_.infos)
                  {
                     _loc3_ = _loc9_.infos[_loc4_];
                     if(!_loc3_)
                     {
                        return;
                     }
                     _appellTopView = new AppellView(_loc3_);
                     _appellContainer.addChild(_appellTopView);
                     _appellTopView.x = (347 - _appellTopView.appellWidth) * 0.5;
                     _loc2_ = "";
                     _loc5_ = TempleteManager.instance.getSkillTemplateInfoByIds(_loc3_.Skills);
                     _loc8_ = 0;
                     while(_loc8_ < _loc5_.length)
                     {
                        if(_loc2_)
                        {
                           _loc2_ += "<br/>";
                        }
                        _loc6_ = _loc5_[_loc8_] as SkillTempInfo;
                        _loc2_ += _loc6_.TemplateName;
                        _loc8_++;
                     }
                     if(_loc3_.Buffs)
                     {
                        _loc11_ = _loc9_.getAdditionFromBuffer(_loc3_.Buffs);
                        _loc10_ = 0;
                        while(_loc10_ < _loc11_.length)
                        {
                           if(_loc2_)
                           {
                              _loc2_ += "<br/>";
                           }
                           _loc2_ += _loc11_[_loc10_];
                           _loc10_++;
                        }
                     }
                     if(_loc9_.isOpenAppellAddition && Boolean(_loc3_.isGet))
                     {
                        _propertyTxt.setFrame(1);
                     }
                     else
                     {
                        if(_loc2_)
                        {
                           _loc2_ = LanguageMgr.GetTranslation("appellFrame.property") + _loc2_;
                        }
                        if(!_loc9_.isOpenAppellAddition)
                        {
                           if(_loc2_)
                           {
                              _loc2_ += "\n";
                           }
                           _loc2_ += LanguageMgr.GetTranslation("appellFrame.noOpen");
                        }
                        _propertyTxt.setFrame(2);
                     }
                     _propertyTxt.htmlText = _loc2_;
                     _propertyTxt.y = int(218 + (50 - _propertyTxt.textHeight) * 0.5);
                  }
               }
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Object) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         _index = param1.frameData as int;
         refreshView();
         FrameControllerManager.instance.christmasController.setPreFrame("");
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_appellName);
         _appellName = null;
         ObjectUtils.disposeObject(_appellAtt);
         _appellAtt = null;
         ObjectUtils.disposeAllChildren(_appellContainer);
         _appellContainer = null;
         ObjectUtils.disposeAllChildren(_vbox);
         _vbox = null;
         super.dispose();
         FrameControllerManager.instance.christmasController.setPreFrame("christmas");
      }
   }
}

