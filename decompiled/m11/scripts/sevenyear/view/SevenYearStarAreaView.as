package sevenyear.view
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import funny.mountact.MountsAvatarView;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import managers.SevenYearManager;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import mvc.module.stararea.event.StarareaEvent;
   import sevenyear.view.help.SevenYearStarAreaHelpFrame;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.StarareaRoadsTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class SevenYearStarAreaView extends Component
   {
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _txtStarareaContent:FilterFrameText;
      
      private var _txtStarareaTime:FilterFrameText;
      
      private var _txtStarareaScoreStr1:FilterFrameText;
      
      private var _txtStarareaScoreStr2:FilterFrameText;
      
      private var _txtStarareaScoreValue1:FilterFrameText;
      
      private var _txtStarareaScoreValue2:FilterFrameText;
      
      private var _txtStarareaActionPowerStr:FilterFrameText;
      
      private var _txtStarareaActionPowerValue:FilterFrameText;
      
      private var _btnStarareaPlay:BaseButton;
      
      private var _btnStarareaHelp:BaseButton;
      
      private var _starareaLight:MutipleImage;
      
      private var _bit3:Bitmap;
      
      private var _map:MovieClip;
      
      private var _mountsContainer:Component;
      
      private var _mountsAvatar:MountsAvatarView;
      
      private var _figure1:ShowAvatar;
      
      private var _figure2:ShowAvatar;
      
      private var _figure3:ShowAvatar;
      
      private var _figure4:ShowAvatar;
      
      private var _fContainer1:Component;
      
      private var _fContainer2:Component;
      
      private var _fContainer3:Component;
      
      private var _fContainer4:Component;
      
      private var lineBg:Sprite;
      
      private var _showThane:ThaneInfo;
      
      private var currentThane:ThaneInfo;
      
      public function SevenYearStarAreaView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc2_:MountTemplate = null;
         var _loc3_:GoodsInfo = null;
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.SevenYearStararea.str2");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.SevenYearStararea.str3");
         _txtStarareaContent = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaContent");
         _txtStarareaTime = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaTime");
         _txtStarareaScoreStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaScoreStr1");
         _txtStarareaScoreStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaScoreStr2");
         _txtStarareaScoreValue1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaScoreValue1");
         _txtStarareaScoreValue2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaScoreValue2");
         _txtStarareaActionPowerStr = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaActionPowerStr");
         _txtStarareaActionPowerValue = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtStarareaActionPowerValue");
         _btnStarareaPlay = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnStarareaPlay");
         _btnStarareaHelp = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnStarareaHelp");
         _starareaLight = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.starareaLight");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.SevenYearStararea.bg");
         addChild(_bit3);
         addChild(_bit1);
         addChild(_bit2);
         addChild(_txtStarareaTime);
         addChild(_txtStarareaScoreStr1);
         addChild(_txtStarareaScoreStr2);
         addChild(_txtStarareaScoreValue1);
         addChild(_txtStarareaScoreValue2);
         addChild(_txtStarareaActionPowerStr);
         addChild(_txtStarareaActionPowerValue);
         addChild(_btnStarareaPlay);
         addChild(_starareaLight);
         lineBg = new Sprite();
         lineBg.filters = [new GlowFilter(16777215,0.3,15,15,5)];
         addChild(lineBg);
         _map = ComponentFactory.Instance.creatCustomObject("asset.SevenYearStararea.line");
         addChild(_map);
         _map.visible = false;
         lineBg.x = _map.x;
         lineBg.y = _map.y;
         lineBg.visible = false;
         showFigure();
         _mountsAvatar = new MountsAvatarView();
         _mountsContainer = new Component();
         addChild(_mountsContainer);
         _mountsContainer.addChild(_mountsAvatar);
         _mountsAvatar.scaleX = _mountsAvatar.scaleY = 0.5;
         _mountsAvatar.mouseChildren = false;
         _mountsContainer.x = 814;
         _mountsContainer.y = 283;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(StarareaManager.instance.model.mountsId);
         if(_loc1_)
         {
            _loc2_ = TempleteManager.instance.mountTemplateDic[_loc1_.Property1];
            _mountsAvatar.data = _loc2_;
            _mountsContainer.tipStyle = "yishi.view.tips.goods.MountCardTip";
            _mountsContainer.isFollowMouse = false;
            _mountsContainer.tipDirctions = "4,1,6,5,2,7,0,3";
            _mountsContainer.tipGapH = 0;
            _mountsContainer.tipGapV = 0;
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc1_.TemplateId;
            _mountsContainer.tipData = _loc3_;
         }
         addChild(_btnStarareaHelp);
         _btnStarareaPlay.enable = false;
         StarareaManager.instance.sendOpenView();
      }
      
      private function showFigure() : void
      {
         _fContainer1 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         _fContainer2 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         _fContainer3 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         _fContainer4 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         addChild(_fContainer1);
         addChild(_fContainer2);
         addChild(_fContainer3);
         addChild(_fContainer4);
         _figure1 = new ShowAvatar(true);
         _figure2 = new ShowAvatar(true);
         _figure3 = new ShowAvatar(true);
         _figure4 = new ShowAvatar(true);
         _fContainer1.addChild(_figure1);
         _fContainer2.addChild(_figure2);
         _fContainer3.addChild(_figure3);
         _fContainer4.addChild(_figure4);
         _figure1.scaleX = _figure1.scaleY = 0.5;
         _figure2.scaleX = _figure2.scaleY = 0.5;
         _figure3.scaleX = _figure3.scaleY = 0.5;
         _figure4.scaleX = _figure4.scaleY = 0.5;
         _fContainer1.x = 51;
         _fContainer1.y = 35;
         _fContainer2.x = 545;
         _fContainer2.y = 35;
         _fContainer3.x = 15;
         _fContainer3.y = 350;
         _fContainer4.x = 596;
         _fContainer4.y = 350;
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[0]),_fContainer1);
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[1]),_fContainer2);
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[2]),_fContainer3);
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[3]),_fContainer4);
      }
      
      private function handleFashion(param1:Array, param2:Component) : void
      {
         var _loc6_:* = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:ShowAvatar = param2.getChildAt(0) as ShowAvatar;
         var _loc7_:GoodsTemplateInfo = param1[0];
         if(_loc7_ == null)
         {
            return;
         }
         if(_loc7_.isViceEquip)
         {
            currentThane = ArmyManager.instance.vice;
         }
         else
         {
            currentThane = ArmyManager.instance.thane;
         }
         _showThane = new ThaneInfo();
         _showThane.templateId = currentThane.templateId;
         var _loc4_:Array = [];
         for each(_loc7_ in param1)
         {
            switch(int(_loc7_.SonType) - 109)
            {
               case 0:
                  _showThane.wingAvata = _loc7_.Avata;
                  break;
               case 1:
                  _showThane.hairFashionAvata = _loc7_.Avata;
                  break;
               case 2:
                  _showThane.armsFashionAvata = _loc7_.Avata;
                  break;
               case 3:
                  _showThane.bodyFashionAvata = _loc7_.Avata;
            }
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc7_.TemplateId;
            _loc5_.identityed = FashionManager.instance.fashionModel.hasIdentityedBook(_loc7_.TemplateId);
            _loc4_.push(_loc5_);
         }
         param2.tipData = _loc4_;
         _loc3_.data = _showThane;
      }
      
      private function initPoint() : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _map.visible = true;
         _loc1_ = 0;
         while(_loc1_ < model.nodes.length)
         {
            _loc2_ = int(model.nodes[_loc1_]);
            _loc3_ = _map.getChildByName("star" + (int(_loc1_ + 1))) as MovieClip;
            if(_loc3_ != null)
            {
               if(_loc2_ == -1)
               {
                  _loc3_.visible = true;
               }
               else
               {
                  _loc3_.visible = false;
               }
            }
            _loc1_++;
         }
         initLines();
      }
      
      private function initLines() : void
      {
         var _loc5_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:StarareaRoadsTemplate = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         lineBg.visible = true;
         var _loc7_:int = 3;
         lineBg.graphics.clear();
         _loc4_ = 0;
         while(_loc4_ < model.roads.length)
         {
            _loc2_ = int(model.roads[_loc4_]);
            _loc1_ = TempleteManager.instance.starareaRoadsTempCate.getTempleteById(_loc4_ + 1);
            _loc5_ = _map.getChildByName("star" + _loc1_.Node1) as MovieClip;
            _loc8_ = _map.getChildByName("star" + _loc1_.Node2) as MovieClip;
            _loc3_ = int(model.nodes[_loc1_.Node1 - 1]);
            _loc6_ = int(model.nodes[_loc1_.Node2 - 1]);
            if(_loc3_ < 100 || _loc6_ < 100)
            {
               if(_loc2_ == 0)
               {
                  lineBg.graphics.lineStyle(_loc7_,8896510,0.7);
                  lineBg.graphics.moveTo(_loc5_.x,_loc5_.y);
                  lineBg.graphics.lineTo(_loc8_.x,_loc8_.y);
               }
            }
            _loc4_++;
         }
         lineBg.cacheAsBitmap = true;
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      public function refreshView() : void
      {
      }
      
      private function initEvent() : void
      {
         _btnStarareaPlay.addEventListener("click",onClickPlay);
         StarareaManager.instance.addEventListener("UPDATE_TAB_VIEW",updateTabView);
         _btnStarareaHelp.addEventListener("click",onClickHelp);
      }
      
      protected function onClickHelp(param1:MouseEvent) : void
      {
         var _loc2_:SevenYearStarAreaHelpFrame = ComponentFactory.Instance.creatComponentByStylename("sevenyear.stararea.help");
         _loc2_.show();
      }
      
      private function removeEvent() : void
      {
         _btnStarareaPlay.removeEventListener("click",onClickPlay);
         StarareaManager.instance.removeEventListener("UPDATE_TAB_VIEW",updateTabView);
         _btnStarareaHelp.removeEventListener("click",onClickHelp);
      }
      
      private function onClickPlay(param1:MouseEvent) : void
      {
         if(SevenYearManager.instance.model.checkFlag())
         {
            SceneManager.instance.setScene("STARAREA_SCENE");
         }
      }
      
      private function updateTabView(param1:StarareaEvent) : void
      {
         _btnStarareaPlay.enable = true;
         initPoint();
         _txtStarareaScoreStr1.text = LanguageMgr.GetTranslation("stararea.str2",model.boxScore1);
         _txtStarareaScoreStr2.text = LanguageMgr.GetTranslation("stararea.str3",model.boxScore2);
         _txtStarareaScoreValue1.text = model.totalSmallBox - model.mySmallBoxCount + "/" + model.totalSmallBox;
         _txtStarareaScoreValue2.text = model.totalBigBox - model.myBigBoxCount + "/" + model.totalBigBox;
         _txtStarareaActionPowerStr.text = LanguageMgr.GetTranslation("stararea.str5");
         _txtStarareaActionPowerValue.text = model.actionPower + "/" + model.totalActionPower;
         _txtStarareaContent.text = LanguageMgr.GetTranslation("stararea.str1",92 - 4 - model.totalSmallBox,model.boxScore1,4 + model.totalSmallBox,model.boxScore2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_txtStarareaContent);
         _txtStarareaContent = null;
         ObjectUtils.disposeObject(_txtStarareaTime);
         _txtStarareaTime = null;
         ObjectUtils.disposeObject(_txtStarareaScoreStr1);
         _txtStarareaScoreStr1 = null;
         ObjectUtils.disposeObject(_txtStarareaScoreStr2);
         _txtStarareaScoreStr2 = null;
         ObjectUtils.disposeObject(_txtStarareaScoreValue1);
         _txtStarareaScoreValue1 = null;
         ObjectUtils.disposeObject(_txtStarareaScoreValue2);
         _txtStarareaScoreValue2 = null;
         ObjectUtils.disposeObject(_txtStarareaActionPowerStr);
         _txtStarareaActionPowerStr = null;
         ObjectUtils.disposeObject(_txtStarareaActionPowerValue);
         _txtStarareaActionPowerValue = null;
         ObjectUtils.disposeObject(_btnStarareaPlay);
         _btnStarareaPlay = null;
         ObjectUtils.disposeObject(_btnStarareaHelp);
         _btnStarareaHelp = null;
         ObjectUtils.disposeObject(_starareaLight);
         _starareaLight = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_map);
         _map = null;
         ObjectUtils.disposeObject(_mountsContainer);
         _mountsContainer = null;
         ObjectUtils.disposeObject(_mountsAvatar);
         _mountsAvatar = null;
         ObjectUtils.disposeObject(_figure1);
         _figure1 = null;
         ObjectUtils.disposeObject(_figure2);
         _figure2 = null;
         ObjectUtils.disposeObject(_figure3);
         _figure3 = null;
         ObjectUtils.disposeObject(_figure4);
         _figure4 = null;
         ObjectUtils.disposeObject(_fContainer1);
         _fContainer1 = null;
         ObjectUtils.disposeObject(_fContainer2);
         _fContainer2 = null;
         ObjectUtils.disposeObject(_fContainer3);
         _fContainer3 = null;
         ObjectUtils.disposeObject(_fContainer4);
         _fContainer4 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         currentThane = null;
         _showThane = null;
      }
   }
}

