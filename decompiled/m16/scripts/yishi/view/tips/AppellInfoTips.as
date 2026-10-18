package yishi.view.tips
{
   import avatar.view.SimpleAvatarView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.AppellManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PathManager;
   
   public class AppellInfoTips extends BaseTip implements IEnterFrame
   {
      
      private var _container:VBox;
      
      private var _appellTopDescribe:FilterFrameText;
      
      private var _appellTopView:SimpleAvatarView;
      
      private var _line:ScaleBitmapImage;
      
      private var _appellTalkDescribe:FilterFrameText;
      
      private var _appellTalkView:MovieClip;
      
      public function AppellInfoTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         EnterFrameManager.instance.registeEnterFrame(this);
         _container = ComponentFactory.Instance.creatComponentByStylename("tips.TipContain");
         _appellTopDescribe = ComponentFactory.Instance.creatComponentByStylename("tips.AppellInfoTips.AppellTopDescribe");
         _line = ComponentFactory.Instance.creatComponentByStylename("tips.AppellInfoTips.AppellInfoTipsLine");
         _appellTalkDescribe = ComponentFactory.Instance.creatComponentByStylename("tips.AppellInfoTips.AppellTalkDescribe");
         addChild(_container);
      }
      
      public function enterFrame() : void
      {
         if(_appellTopView)
         {
            _appellTopView.draw();
         }
      }
      
      private function clean() : void
      {
         _container.removeAllChild();
         _container.refreshChildPos();
         if(_appellTopView && _appellTopView.parent)
         {
            _appellTopView.parent.removeChild(_appellTopView);
         }
         ObjectUtils.disposeObject(_appellTopView);
         _appellTopView = null;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:String = null;
         clean();
         if(_data is AppellInfoTemplate)
         {
            _appellTopView = new SimpleAvatarView(_data.ImgWidth,_data.ImgHeight,PathManager.getAppellImgPath(_data.TemplateId),_data.ImgCount);
            _appellTopView.drawFrame = _data.ImgFrame;
            _appellTopDescribe.text = LanguageMgr.GetTranslation("yishi.view.tips.AppellInfoTips.AppellTopDescribeTxt");
            _appellTalkDescribe.text = LanguageMgr.GetTranslation("yishi.view.tips.AppellInfoTips.AppellTalkDescribeTxt");
            _container.addChild(_appellTopDescribe);
            _container.addChild(_appellTopView);
            if(_data.Perfix != "")
            {
               _loc1_ = "chatII.Appell" + AppellManager.instance.model.getPerfixStyle(_data.TemplateId);
               _appellTalkView = ComponentFactory.Instance.creatCustomObject(_loc1_);
               _container.addChild(_line);
               _container.addChild(_appellTalkDescribe);
               _container.addChild(_appellTalkView);
            }
            _appellTopView.x = (_container.width - _appellTopView.width) * 0.5;
            _line.width = _container.width;
            if(_appellTalkView)
            {
               _appellTalkView.x = (_container.width - _appellTalkView["content"].width) * 0.5;
            }
            _bg.width = _container.x + _container.width + 15;
            _bg.height = _container.y + _container.height + 15;
         }
      }
      
      override public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         clean();
         if(_appellTopDescribe)
         {
            ObjectUtils.disposeObject(_appellTopDescribe);
         }
         _appellTopDescribe = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         if(_appellTalkDescribe)
         {
            ObjectUtils.disposeObject(_appellTalkDescribe);
         }
         _appellTalkDescribe = null;
         if(_appellTalkView)
         {
            ObjectUtils.disposeObject(_appellTalkView);
         }
         _appellTalkView = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

