package battle.view.battleresult
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.battle.BaseItemMsg;
   import com.road.yishi.proto.battle.BattleReportMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class SinglePassVicotyResultView extends BaseBattleResultView
   {
      
      private var _msg:BattleReportMsg;
      
      private var _numberBit1:BitmapData;
      
      private var _numberBit2:BitmapData;
      
      private var _numberBit3:BitmapData;
      
      private var _closeBtn:BaseButton;
      
      public function SinglePassVicotyResultView()
      {
         super(null);
         addEventListener("addedToStage",__onStage);
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function initView() : void
      {
         var _loc15_:BaseItemMsg = null;
         var _loc7_:int = 0;
         var _loc16_:GoodsInfo = null;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc14_:Component = null;
         var _loc4_:BaseItemView = null;
         var _loc1_:Bitmap = null;
         var _loc10_:Sprite = null;
         var _loc6_:BaseIconView = null;
         _numberBit1 = ClassUtils.CreatInstance("asset.campaign.Number1");
         _numberBit2 = ClassUtils.CreatInstance("asset.campaign.Number2");
         _numberBit3 = ClassUtils.CreatInstance("asset.campaign.Number3");
         mc = ComponentFactory.Instance.creat("asset.singlePass.BattleResultBg");
         mc.mouseEnabled = false;
         NumberViewUtils.refreshValue(_msg.strategyBonus,mc["curDamge"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(_msg.posX,mc["curBeDamge"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(_msg.param1,mc["standDamge"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(_msg.param2,mc["standBeDamge"],_numberBit1,25,25,15,25,"0123456789:");
         mc.scoreA.gotoAndStop(_msg.goldBonus);
         mc.scoreB.gotoAndStop(_msg.posY);
         NumberViewUtils.refreshValue(_msg.gpBonus,mc.exp,_numberBit2,24,30,16,24,"0123456789");
         if(_msg.petGpBonus < 0)
         {
            _msg.petGpBonus = 0;
         }
         NumberViewUtils.refreshValue(_msg.petGpBonus,mc.petExp,_numberBit3,24,30,15,24,"0123456789");
         ObjectUtils.disposeAllChildren(mc.totalScore);
         var _loc13_:String = "asset.campaign.ProfileMCS";
         switch(_msg.battleScene - 1)
         {
            case 0:
               _loc13_ = "asset.campaign.ProfileMCD";
               break;
            case 1:
               _loc13_ = "asset.campaign.ProfileMCC";
               break;
            case 2:
               _loc13_ = "asset.campaign.ProfileMCB";
               break;
            case 3:
               _loc13_ = "asset.campaign.ProfileMCA";
               break;
            case 4:
               _loc13_ = "asset.campaign.ProfileMCS";
               break;
            case 5:
               _loc13_ = "asset.campaign.ProfileMCSS";
               break;
            case 6:
               _loc13_ = "asset.campaign.ProfileMCSSS";
         }
         mc.totalScore.addChild(ClassUtils.CreatInstance(_loc13_));
         var _loc12_:HBox = ComponentFactory.Instance.creatComponentByStylename("battle.ResultHBox");
         var _loc11_:int = int(_msg.baseItem.length);
         var _loc2_:Array = [];
         var _loc8_:Dictionary = new Dictionary(true);
         _loc7_ = 0;
         while(_loc7_ < _loc11_)
         {
            _loc15_ = _msg.baseItem[_loc7_] as BaseItemMsg;
            if(_loc15_.templateId != -700)
            {
               _loc16_ = _loc8_[_loc15_.templateId] as GoodsInfo;
               if(!_loc16_)
               {
                  _loc16_ = new GoodsInfo();
               }
               _loc16_.templateId = _loc15_.templateId;
               _loc16_.count += _loc15_.count;
               if(!(_loc15_.templateId in _loc8_))
               {
                  _loc2_.push(_loc16_);
                  _loc8_[_loc15_.templateId] = _loc16_;
               }
            }
            _loc7_++;
         }
         _loc2_.sort(compareFunction);
         _loc9_ = 0;
         while(_loc9_ < _loc2_.length)
         {
            _loc16_ = _loc2_[_loc9_] as GoodsInfo;
            _loc3_ = _loc16_.count;
            _loc16_.count = 0;
            _loc14_ = new Component();
            _loc4_ = ComponentFactory.Instance.creatCustomObject("battle.ResultItem");
            _loc4_.data = _loc16_;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.singlePass.Star");
            _loc1_.x = 65;
            _loc1_.y = 23;
            _loc10_ = new Sprite();
            _loc10_.x = 78;
            _loc10_.y = 19;
            NumberViewUtils.refreshValue(_loc3_,_loc10_,_numberBit1,25,25,15,25,"0123456789:");
            _loc14_.addChild(_loc4_);
            _loc14_.addChild(_loc1_);
            _loc14_.addChild(_loc10_);
            _loc12_.addChild(_loc14_);
            _loc9_++;
         }
         var _loc5_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc5_.enterWarPet)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("battle.PetIcon2");
            _loc6_.icon = IconFactory.getPetHeadSmallIcon(_loc5_.enterWarPet.templateId);
            mc.petIcon.addChild(_loc6_);
         }
         else
         {
            mc.petIcon.visible = false;
            mc.petExplabel.visible = false;
            mc.addFlag.visible = false;
            mc.petExp.visible = false;
         }
         addChild(mc);
         addChild(_loc12_);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
         _closeBtn.x = 796;
         _closeBtn.y = 6;
         addChild(_closeBtn);
         _closeBtn.addEventListener("click",__closeHandler);
      }
      
      private function compareFunction(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(param1.count < param2.count)
         {
            return -1;
         }
         if(param1.count > param2.count)
         {
            return 1;
         }
         return 0;
      }
      
      private function __onStage(param1:Event) : void
      {
         try
         {
            initView();
         }
         catch(err:Error)
         {
            dispose();
         }
      }
      
      override public function show() : void
      {
         var view:Sprite = this;
         CheckUIModuleUtil.instance.tryCall("clearance",function():void
         {
            LayerManager.Instance.addToLayer(view,2,true,true,1,0,true);
            view.x = (StageReferance.stage.stageWidth - view.width) * 0.5;
            view.y = (StageReferance.stage.stageHeight - view.height) * 0.5;
         });
      }
      
      override public function dispose() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeHandler);
         }
         removeEventListener("addedToStage",__onStage);
         ObjectUtils.disposeObject(_numberBit1);
         _numberBit1 = null;
         ObjectUtils.disposeObject(_numberBit2);
         _numberBit2 = null;
         ObjectUtils.disposeObject(_numberBit3);
         _numberBit3 = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         _msg = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         FrameControllerManager.instance.openControllerByInfo("singlepass");
      }
      
      override public function get width() : Number
      {
         return 800;
      }
      
      override public function get height() : Number
      {
         return 385;
      }
      
      public function get msg() : BattleReportMsg
      {
         return _msg;
      }
      
      public function set msg(param1:BattleReportMsg) : void
      {
         _msg = param1;
      }
   }
}

