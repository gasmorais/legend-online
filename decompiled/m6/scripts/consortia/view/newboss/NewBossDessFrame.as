package consortia.view.newboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.newboss.item.NewBossDesItem;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   
   public class NewBossDessFrame extends Frame
   {
      
      public var _bg:MutipleImage;
      
      public var _confrim:IconButton;
      
      public var _desTxt1:FilterFrameText;
      
      public var _desTxt2:FilterFrameText;
      
      public var _vb1:VBox;
      
      public var _vb2:VBox;
      
      private var _sp1:ScrollPanel;
      
      private var _tipdes:FilterFrameText;
      
      public function NewBossDessFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consorienewboss.skip.helpTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.bg");
         _confrim = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.confrim");
         _desTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.desTxt1");
         _desTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.desTxt2");
         _vb1 = ComponentFactory.Instance.creatCustomObject("ui.consortianewboss.vb1");
         _vb2 = ComponentFactory.Instance.creatCustomObject("ui.consortianewboss.vb2");
         _sp1 = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBoss.Spanel1");
         _tipdes = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.Nodetip");
         addToContent(_bg);
         addToContent(_confrim);
         addToContent(_desTxt1);
         addToContent(_desTxt2);
         addToContent(_sp1);
         addToContent(_vb2);
         addToContent(_tipdes);
         _sp1.setView(_vb1);
         _desTxt1.text = LanguageMgr.GetTranslation("consorienewboss.skip.des1");
         _desTxt2.text = LanguageMgr.GetTranslation("consorienewboss.skip.des2");
         _tipdes.text = LanguageMgr.GetTranslation("consorienewboss.node.tip");
      }
      
      private function initData() : void
      {
         var _loc10_:Array = null;
         var _loc2_:NewBossDesItem = null;
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc6_:String = null;
         var _loc8_:int = 0;
         var _loc3_:NewBossDesItem = null;
         var _loc9_:int = 0;
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_newboss_time");
         if(_loc4_)
         {
            _vb1.beginChanges();
            _loc10_ = _loc4_.ConfigValue.split("|");
            _loc5_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc10_.length)
            {
               _loc6_ = _loc10_[_loc8_];
               _loc1_ = _loc6_.split(",");
               _loc2_ = new NewBossDesItem();
               _loc2_.refreshView(_loc5_ + "-" + _loc1_[0],_loc1_[1]);
               _loc5_ = int(_loc1_[0]);
               _vb1.addChild(_loc2_);
               _loc8_++;
            }
            _vb1.commitChanges();
            _sp1.invalidateViewport();
         }
         var _loc7_:int = 2;
         var _loc11_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_newboss_param");
         if(_loc11_)
         {
            _loc7_ = int(_loc11_.ConfigValue);
         }
         _vb2.beginChanges();
         _loc9_ = 2;
         while(_loc9_ < 5)
         {
            _loc3_ = new NewBossDesItem();
            if(_loc9_ == 4)
            {
               if(_loc7_ > 1)
               {
                  _loc3_.refreshView("n","7 + " + _loc7_ + " * (n - 1)");
               }
               else
               {
                  _loc3_.refreshView("n","7 + (n - 1)");
               }
            }
            else if(_loc7_ > 1)
            {
               _loc3_.refreshView("" + _loc9_,"7 + " + _loc7_ + " * (" + (_loc9_ - 1) + ")");
            }
            else
            {
               _loc3_.refreshView("" + _loc9_,"7 + (" + (_loc9_ - 1) + ")");
            }
            _vb2.addChild(_loc3_);
            _loc9_++;
         }
         _vb2.commitChanges();
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confrim.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confrim.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         dispose();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_confrim);
         _confrim = null;
         ObjectUtils.disposeObject(_desTxt1);
         _desTxt1 = null;
         ObjectUtils.disposeObject(_desTxt2);
         _desTxt2 = null;
         ObjectUtils.disposeObject(_vb1);
         _vb1 = null;
         ObjectUtils.disposeObject(_vb2);
         _vb2 = null;
         ObjectUtils.disposeObject(_sp1);
         _sp1 = null;
         ObjectUtils.disposeObject(_tipdes);
         _tipdes = null;
         super.dispose();
      }
   }
}

